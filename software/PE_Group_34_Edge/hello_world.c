/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <time.h>
#include <stdlib.h>
#include <stdio.h>

#include "system.h"
#include "io.h"

#include "sys/alt_dma.h"
#include "sys/alt_cache.h"
#include "altera_avalon_dma_regs.h"

#include <sys/time.h>
#include "nios2.h"

#include <altera_avalon_performance_counter.h>

union FloatingPointIEEE754 {
	unsigned int IEEE_float : 32;
	float float_num;
} number;

//#define WEIGHT_DATA_SIZE 908720
//#define IMAGE_DATA_SIZE 150528

//#define WEIGHTS_DATA_SIZE 908720

#define WEIGHTS_DATA_SIZE 432
#define IMAGE_DATA_SIZE 150528
#define IMG2COL_DATA_SIZE 351232
#define OUTPUT_DATA_SIZE 802816

#define WEIGHTS_DATA_BASE_ADDRESS 0
#define IMAGE_DATA_BASE_ADDRESS 10000
#define IMG2COL_DATA_BASE_ADDRESS 200000
#define OUTPUT_DATA_BASE_ADDRESS 600000
#define ANSWER_DATA_BASE_ADDRESS 2000000

#define PE_SIZE_X 4
#define PE_SIZE_Y 3
#define Collect_Count 4

float get_pixel(int height, int width, int channels,
                        int row, int col, int channel, int pad)
{
    row -= pad;
    col -= pad;

    if (row < 0 || col < 0 ||
        row >= height || col >= width) return 0;
    number.IEEE_float = IORD(UNIPHY_DDR3_BASE, IMAGE_DATA_BASE_ADDRESS + col + width*(row + height*channel));
    return number.float_num;
}

void im2col(int channels,  int height,  int width,
     int ksize,  int stride, int pad)
{
    int c,h,w;
    int height_col = (height + 2*pad - ksize) / stride + 1;
    int width_col = (width + 2*pad - ksize) / stride + 1;

    int channels_col = channels * ksize * ksize;
    for (c = 0; c < channels_col; ++c) {
        int w_offset = c % ksize;
        int h_offset = (c / ksize) % ksize;
        int c_im = c / ksize / ksize;
        for (h = 0; h < height_col; ++h) {
            for (w = 0; w < width_col; ++w) {
                int im_row = h_offset + h * stride;
                int im_col = w_offset + w * stride;
                int col_index = (c * height_col + h) * width_col + w;
                number.float_num = get_pixel(height, width, channels,
                        im_row, im_col, c_im, pad);
                IOWR(UNIPHY_DDR3_BASE, IMG2COL_DATA_BASE_ADDRESS + col_index, number.IEEE_float);
            }
        }
    }
}

void gemm_no_tile(int M, int N, int K, int lda, int ldb, int ldc)
{
    int i, j, k;
    float data_A, data_B, data_C;

    for (i = 0; i < M; ++i) {
        for (k = 0; k < K; ++k) {
            //register float A_PART = ALPHA * A[i * lda + k];
            number.IEEE_float = IORD(UNIPHY_DDR3_BASE, WEIGHTS_DATA_BASE_ADDRESS + i * lda + k);
            data_A = number.float_num;
            for (j = 0; j < N; ++j) {
                //C[i*ldc + j] += A_PART*B[k*ldb + j];
            	number.IEEE_float = IORD(UNIPHY_DDR3_BASE, IMG2COL_DATA_BASE_ADDRESS + k*ldb + j);
            	data_B = number.float_num;
            	number.IEEE_float = IORD(UNIPHY_DDR3_BASE, OUTPUT_DATA_BASE_ADDRESS + i*ldc + j);
            	data_C = number.float_num;

            	data_C += data_A * data_B;

            	number.float_num = data_C;
            	IOWR(UNIPHY_DDR3_BASE, OUTPUT_DATA_BASE_ADDRESS + i*ldc + j, number.IEEE_float);
            }
        }
    }
}

void gemm_nn(int M, int N, int K, float ALPHA,
    float *A, int lda,
    float *B, int ldb,
    float *C, int ldc)
{
    int i, j, k;
    for (i = 0; i < M; ++i) {
        for (k = 0; k < K; ++k) {
            register float A_PART = ALPHA * A[i * lda + k];
            for (j = 0; j < N; ++j) {
                C[i*ldc + j] += A_PART*B[k*ldb + j];
            }
        }
    }
}

void gemm_cpu(int TA, int TB, int M, int N, int K, float ALPHA,
        float *A, int lda,
        float *B, int ldb,
        float BETA,
        float *C, int ldc)
{
    //printf("cpu: %d %d %d %d %d %f %d %d %f %d\n",TA, TB, M, N, K, ALPHA, lda, ldb, BETA, ldc);
    if (BETA != 1){
        int i, j;
        for(i = 0; i < M; ++i){
            for(j = 0; j < N; ++j){
                C[i*ldc + j] *= BETA;
            }
        }
    }

    int t;
    #pragma omp parallel for
    for (t = 0; t < M; ++t) {
        if (!TA && !TB)
            gemm_nn(1, N, K, ALPHA, A + t*lda, lda, B, ldb, C + t*ldc, ldc);
    }
}

void PE_Instruction_Block(float *PE_Weight, float *PE_Img2Col, float *PE_Output){
	number.float_num = PE_Weight[0];
	ALT_CI_PE_INSTRUCTION_0(1,number.IEEE_float);

	number.float_num = PE_Img2Col[0];
	ALT_CI_PE_INSTRUCTION_0(2,number.IEEE_float);

	number.float_num = PE_Output[0];
	ALT_CI_PE_INSTRUCTION_0(3,number.IEEE_float);

	number.float_num = PE_Weight[1];
	ALT_CI_PE_INSTRUCTION_0(1,number.IEEE_float);

	number.float_num = PE_Img2Col[1];
	ALT_CI_PE_INSTRUCTION_0(2,number.IEEE_float);

	number.float_num = PE_Output[1];
	ALT_CI_PE_INSTRUCTION_0(3,number.IEEE_float);

	number.float_num = PE_Weight[2];
	ALT_CI_PE_INSTRUCTION_0(1,number.IEEE_float);

	number.float_num = PE_Img2Col[2];
	ALT_CI_PE_INSTRUCTION_0(2,number.IEEE_float);

	number.float_num = PE_Output[2];
	ALT_CI_PE_INSTRUCTION_0(3,number.IEEE_float);

	number.float_num = PE_Img2Col[3];
	ALT_CI_PE_INSTRUCTION_0(2,number.IEEE_float);

	number.float_num = PE_Output[3];
	ALT_CI_PE_INSTRUCTION_0(3,number.IEEE_float);

	number.float_num = PE_Img2Col[4];
	ALT_CI_PE_INSTRUCTION_0(2,number.IEEE_float);

	number.float_num = PE_Img2Col[5];
	ALT_CI_PE_INSTRUCTION_0(2,number.IEEE_float);
}

void PE_Instruction(int M, int N, int K, float *Tile_Weight, float *Tile_Img2Col, float *Tile_Output){

    int i, j, p;
    int index, index2;

	float *PE_Output;
	PE_Output = (float*)malloc(sizeof(float) * PE_SIZE_X);

	float *PE_Weight;
	PE_Weight = (float*)malloc(sizeof(float) * PE_SIZE_Y);

	float *PE_Img2Col;
	PE_Img2Col = (float*)malloc(sizeof(float) * (PE_SIZE_X + PE_SIZE_Y - 1));

    for(i = 0; i < M; i++){
        for(j = 0; j < N / PE_SIZE_X; j++){
            //Fill Output PE
            for(index = 0; index < PE_SIZE_X; index++){
                PE_Output[index] = Tile_Output[i * N + j * PE_SIZE_X + index];
            }
            for(p = 0; p < K / PE_SIZE_Y; p++){
                //Fill Weight PE
                for(index = 0; index < PE_SIZE_Y; index++){
                    PE_Weight[index] = Tile_Weight[i * K + p * PE_SIZE_Y + index];
                }
                //Fill Img2Col PE
                for(index = 0; index < (PE_SIZE_X + PE_SIZE_Y - 1); index++){
                    PE_Img2Col[index] = Tile_Img2Col[j * (PE_SIZE_X + PE_SIZE_Y - 1) * (K / PE_SIZE_Y) + p * (PE_SIZE_X + PE_SIZE_Y - 1) + index];
                }

                PE_Instruction_Block(PE_Weight, PE_Img2Col, PE_Output);

                //Clear Output PE
                for(index = 0; index < PE_SIZE_X; index++){
                    PE_Output[index] = 0.0f;
                }
            }
            //Fill Output Tile

        }
    	for(index2 = 0; index2 < N / PE_SIZE_X; index2++){
    		for(index = 0; index < PE_SIZE_X; index++){
    			number.IEEE_float =  ALT_CI_PE_INSTRUCTION_0(4,number.IEEE_float);
    			Tile_Output[index2 * PE_SIZE_X + index] = number.float_num;
    		}
    	}
    }

    //Deal with edge cases
    if(N % PE_SIZE_X != 0){
        int edge_PE_SIZE_X = N % PE_SIZE_X;
        for(i = 0; i < M; i++){
            //Fill Output PE
            for(index = 0; index < edge_PE_SIZE_X; index++){
                PE_Output[index] = Tile_Output[i * N + (N / PE_SIZE_X) * PE_SIZE_X + index];
            }

            for(p = 0; p < K / PE_SIZE_Y; p++){
                //Fill Weight PE
                for(index = 0; index < PE_SIZE_Y; index++){
                    PE_Weight[index] = Tile_Weight[i * K + p * PE_SIZE_Y + index];
                }
                //Fill Img2Col PE
                for(index = 0; index < (edge_PE_SIZE_X + PE_SIZE_Y - 1); index++){
                    PE_Img2Col[index] = Tile_Img2Col[(N / PE_SIZE_X) * (PE_SIZE_X + PE_SIZE_Y - 1) * (K / PE_SIZE_Y) + p * (PE_SIZE_X + PE_SIZE_Y - 1) + index];
                }
                PE_Instruction_Block(PE_Weight, PE_Img2Col, PE_Output);

                //Clear Output PE
                for(index = 0; index < PE_SIZE_X; index++){
                    PE_Output[index] = 0.0f;
                }
            }
            //Fill Output Tile
    		for(index = 0; index < edge_PE_SIZE_X; index++){
    			number.IEEE_float =  ALT_CI_PE_INSTRUCTION_0(4,number.IEEE_float);
    			Tile_Output[index2 * PE_SIZE_X + index] = number.float_num;
    		}
    		for(index = 0; index < PE_SIZE_X - edge_PE_SIZE_X; index++){
    			number.IEEE_float =  ALT_CI_PE_INSTRUCTION_0(4,number.IEEE_float);
    		}
    	}
    }


    free(PE_Output);
    free(PE_Weight);
    free(PE_Img2Col);
}

int main(int argc, char **argv)
{
	alt_u64 time_begin_pe,time_end_pe,cycles_pe;
	alt_u64 time_begin_GEMM,time_end_GEMM,cycles_GEMM;
	alt_u64 time_begin_GEMM_Tile,time_end_GEMM_Tile,cycles_GEMM_Tile;

	unsigned int index0, index1, index2;

	int c, h, w, size, stride, pad, num_filters;
	c = 3;
	h = 122;
	w = 122;
	size = 3;
	stride = 1;
	pad = 1;
	num_filters = 16;

	int m, n, k;
	m = num_filters;
	n = h * w;
	k = size * size * c;

	// Read Image Data to DDR3 Memory
	FILE *fp_image = NULL;
	fp_image = fopen("/mnt/host/image_data.txt", "r");
	if(fp_image == NULL){
		printf("can't open file!\n");
		exit (1);
	}

	for(index0 = 0; index0 < w * h * c; index0++){
		//fscanf(fp_image, "%f\n", &number.float_num);
		number.float_num = 5.0f;
		IOWR(UNIPHY_DDR3_BASE, IMAGE_DATA_BASE_ADDRESS + index0, number.IEEE_float);
		if(index0 % 10000 == 0){
			printf("(Image)%d read\n", index0);
		}
	}
	fclose(fp_image);

	//Read Weight Data to DDR3 Memory
	FILE *fp_weights = NULL;
	fp_weights = fopen("/mnt/host/weights.txt", "r");
	if(fp_weights == NULL){
		printf("can't open file!\n");
		exit (1);
	}
	for(index0 = 0; index0 < m * k; index0++){
		fscanf(fp_weights, "%f\n", &number.float_num);
		IOWR(UNIPHY_DDR3_BASE, WEIGHTS_DATA_BASE_ADDRESS + index0, number.IEEE_float);
	}
	fclose(fp_weights);

	// Set Output Data to DDR3 Memory

	for(index0 = 0; index0 < m * n; index0++){
		number.float_num = 0.0f;
		IOWR(UNIPHY_DDR3_BASE, OUTPUT_DATA_BASE_ADDRESS + index0, number.IEEE_float);
	}


	im2col(c, h, w, size, stride, pad);

    int i, j, p, q, r;

	unsigned int Tile_m_size = 1;
	unsigned int Tile_k_size = 27;
	unsigned int Tile_n_size = 14;

	float *Tile_Output;
	Tile_Output = (float*)malloc(sizeof(float) * Tile_m_size * Tile_n_size);

	float *Tile_Weight;
	Tile_Weight = (float*)malloc(sizeof(float) * Tile_m_size * Tile_k_size);

	float *Tile_Img2Col;
	Tile_Img2Col = (float*)malloc(sizeof(float) * Tile_n_size * Tile_k_size);

	float *Tile_Img2Col_Reduced;
    Tile_Img2Col_Reduced = (float*)malloc(sizeof(float) * (PE_SIZE_X + PE_SIZE_Y - 1) * (k / Tile_k_size) * (n / Tile_n_size));

    int Tile_Img2Col_Reduced_Address[6];
    int b_Address[6];

	printf ("(GEMM)Calculating...\n");
/*
	time_begin_GEMM = perf_get_total_time  ((void*)PERFORMANCE_COUNTER_0_BASE);
	PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);

	gemm_no_tile(m, n, k, k, n, n);

	time_end_GEMM = perf_get_total_time  ((void*)PERFORMANCE_COUNTER_0_BASE);
	PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);

	cycles_GEMM = time_end_GEMM - time_begin_GEMM;
*/

	time_begin_GEMM_Tile = perf_get_total_time  ((void*)PERFORMANCE_COUNTER_0_BASE);
	PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);

	for(i = 0; i < m / Tile_m_size; i++){
		for(j = 0; j < n / Tile_n_size; j++){

			//Fill Tile_Output
			for(index1 = 0; index1 < Tile_m_size; index1++){
				for(index0 = 0; index0 < Tile_n_size; index0++){
					number.IEEE_float = IORD(UNIPHY_DDR3_BASE, OUTPUT_DATA_BASE_ADDRESS + i * Tile_m_size * n + j * Tile_n_size + index1 * n + index0);
					Tile_Output[index1 * Tile_n_size + index0] = number.float_num;
				}
			}

			for(p = 0; p < k / Tile_k_size; p++){

				//Fill Tile_Weight
				for(index1 = 0; index1 < Tile_m_size; index1++){
					for(index0 = 0; index0 < Tile_k_size; index0++){
						number.IEEE_float = IORD(UNIPHY_DDR3_BASE, WEIGHTS_DATA_BASE_ADDRESS + i * Tile_m_size * k + p * Tile_k_size + index1 * k + index0);
						Tile_Weight[index1 * Tile_k_size + index0] = number.float_num;
					}
				}

				//Fill Tile_Col2Img
				for(index1 = 0; index1 < Tile_k_size; index1++){
					for(index0 = 0; index0 < Tile_n_size; index0++){
						number.IEEE_float = IORD(UNIPHY_DDR3_BASE, IMG2COL_DATA_BASE_ADDRESS + p * Tile_k_size * n + j * Tile_n_size + index1 * n + index0);
						Tile_Img2Col[index1 * Tile_n_size + index0] = number.float_num;
					}
				}
				gemm_cpu(0,0,Tile_m_size,Tile_n_size,Tile_k_size,1,Tile_Weight,Tile_k_size,Tile_Img2Col,Tile_n_size,1,Tile_Output,Tile_n_size);

			}
			//Fill Tile_Output
			for(index1 = 0; index1 < Tile_m_size; index1++){
				for(index0 = 0; index0 < Tile_n_size; index0++){
					number.float_num = Tile_Output[index1 * Tile_n_size + index0];
					IOWR(UNIPHY_DDR3_BASE, OUTPUT_DATA_BASE_ADDRESS + i * Tile_m_size * n + j * Tile_n_size + index1 * n + index0, number.IEEE_float);
				}
			}
		}
	}

	time_end_GEMM_Tile = perf_get_total_time  ((void*)PERFORMANCE_COUNTER_0_BASE);
	PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);
	cycles_GEMM_Tile = time_end_GEMM_Tile - time_begin_GEMM_Tile;

	printf ("(PE)Calculating...\n");
	time_begin_pe = perf_get_total_time  ((void*)PERFORMANCE_COUNTER_0_BASE);
	PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);

	for(i = 0; i < m / Tile_m_size; i++){
		for(j = 0; j < n / Tile_n_size; j++){
			//Fill Tile_Output
			for(index1 = 0; index1 < Tile_m_size; index1++){
				for(index0 = 0; index0 < Tile_n_size; index0++){
					number.IEEE_float = IORD(UNIPHY_DDR3_BASE, OUTPUT_DATA_BASE_ADDRESS + i * Tile_m_size * n + j * Tile_n_size + index1 * n + index0);
					Tile_Output[index1 * Tile_n_size + index0] = number.float_num;
				}
			}
			for(p = 0; p < k / Tile_k_size; p++){

				//Fill Tile_Weight
				for(index1 = 0; index1 < Tile_m_size; index1++){
					for(index0 = 0; index0 < Tile_k_size; index0++){
						number.IEEE_float = IORD(UNIPHY_DDR3_BASE, WEIGHTS_DATA_BASE_ADDRESS + i * Tile_m_size * k + p * Tile_k_size + index1 * k + index0);
						Tile_Weight[index1 * Tile_k_size + index0] = number.float_num;
					}
				}

				//Fill Tile_Img2Col_Reduced
                for(index2 = 0; index2 < Tile_n_size / PE_SIZE_X; index2++){
                    for(index1 = 0; index1 < Tile_k_size / PE_SIZE_Y; index1++){
                        for(index0 = 0; index0 < (PE_SIZE_X + PE_SIZE_Y - 1); index0++){
                            Tile_Img2Col_Reduced_Address[index0] =  index2 * (PE_SIZE_X + PE_SIZE_Y - 1) * (Tile_k_size / PE_SIZE_Y) +
                                                                    index1 * (PE_SIZE_X + PE_SIZE_Y - 1) +
                                                                    index0;
                        }

                        for(index0 = 0; index0 < PE_SIZE_X; index0++){
                            b_Address[index0] =
                            j * Tile_n_size + p * Tile_k_size * n +
                            index2 * PE_SIZE_X + index1 * PE_SIZE_Y * n + index0;
                        }
                        for(index0 = 0; index0 < PE_SIZE_Y - 1; index0++){
                            b_Address[PE_SIZE_X + index0] =
                            j * Tile_n_size + p * Tile_k_size * n +
                            index2 * PE_SIZE_X + index1 * PE_SIZE_Y * n + (PE_SIZE_X - 1) + (index0 + 1) * n;
                        }

                        for(index0 = 0; index0 < (PE_SIZE_X + PE_SIZE_Y - 1); index0++){
    						number.IEEE_float = IORD(UNIPHY_DDR3_BASE, IMG2COL_DATA_BASE_ADDRESS + b_Address[index0]);
    						Tile_Img2Col_Reduced[Tile_Img2Col_Reduced_Address[index0]] = number.float_num;
                        }

                    }
                }

                //Edge Case

                if((Tile_n_size % PE_SIZE_X != 0)){
                    for(index1 = 0; index1 < Tile_k_size / PE_SIZE_Y; index1++){
                        for(index0 = 0; index0 < (PE_SIZE_X + PE_SIZE_Y - 1); index0++){
                            Tile_Img2Col_Reduced_Address[index0] =  (Tile_n_size / PE_SIZE_X) * (PE_SIZE_X + PE_SIZE_Y - 1) * (Tile_k_size / PE_SIZE_Y) +
                                                                    index1 * (PE_SIZE_X + PE_SIZE_Y - 1) + index0;
                        }

                        for(index0 = 0; index0 < Tile_n_size % PE_SIZE_X ; index0++){
                            b_Address[index0]
                                = j * Tile_n_size + p * Tile_k_size * n + (Tile_n_size / PE_SIZE_X) * PE_SIZE_X + index1 * PE_SIZE_Y * n + index0;

                            number.IEEE_float = IORD(UNIPHY_DDR3_BASE, IMG2COL_DATA_BASE_ADDRESS + b_Address[index0]);
    						Tile_Img2Col_Reduced[Tile_Img2Col_Reduced_Address[index0]] = number.float_num;
                        }
                        for(index0 = 0; index0 < PE_SIZE_Y - 1; index0++){
                            b_Address[Tile_n_size % PE_SIZE_X - 1 + index0]
                                = j * Tile_n_size + p * Tile_k_size * n + (Tile_n_size / PE_SIZE_X) * PE_SIZE_X +
                                index1 * PE_SIZE_Y * n + (Tile_n_size % PE_SIZE_X) + (index0 + 1) * n - 1;

                            number.IEEE_float = IORD(UNIPHY_DDR3_BASE, IMG2COL_DATA_BASE_ADDRESS + b_Address[Tile_n_size % PE_SIZE_X - 1 + index0]);
    						Tile_Img2Col_Reduced[Tile_Img2Col_Reduced_Address[index0 + Tile_n_size % PE_SIZE_X]] = number.float_num;
                                                    }
                        for(index0 = 0; index0 < PE_SIZE_X - (Tile_n_size % PE_SIZE_X); index0++){
                            Tile_Img2Col_Reduced[Tile_Img2Col_Reduced_Address[index0 + Tile_n_size % PE_SIZE_X + (PE_SIZE_Y - 1)]] = 0;
                        }

                    }
                }

				PE_Instruction(Tile_m_size, Tile_n_size, Tile_k_size, Tile_Weight, Tile_Img2Col_Reduced, Tile_Output);

			}
			//Fill Tile_Output
			for(index1 = 0; index1 < Tile_m_size; index1++){
				for(index0 = 0; index0 < Tile_n_size; index0++){
					number.float_num = Tile_Output[index1 * Tile_n_size + index0];
					IOWR(UNIPHY_DDR3_BASE, OUTPUT_DATA_BASE_ADDRESS + i * Tile_m_size * n + j * Tile_n_size + index1 * n + index0, number.IEEE_float);
				}
			}
		}
	}

	time_end_pe = perf_get_total_time  ((void*)PERFORMANCE_COUNTER_0_BASE);
	PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE);
	cycles_pe = time_end_pe - time_begin_pe;

	free(Tile_Weight);
	free(Tile_Output);
	free(Tile_Img2Col);
	free(Tile_Img2Col_Reduced);

    return 0;
}
