`timescale 1ns/1ns
module PE_Instruction_tb();
    
	reg clk, clk_en, rst;
    reg start;
    reg [2:0] n;
	reg [31:0] dataa;
	
	wire [31:0] result;
    wire done;

    wire [1:0] Kernel_Address;
    wire [1:0] Input_Address;
    wire [0:0] Output_Write_Address;
    wire [0:0] Output_Read_Address;

    PE_Instruction dut
	( .clk(clk), .clk_en(clk_en), .reset(rst), .start(start), .n(n), .done(done), .dataa(dataa), .result(result));
        //.Kernel_Address(Kernel_Address), .Input_Address(Input_Address), .Output_Write_Address(Output_Write_Address),
        //.Output_Read_Address(Output_Read_Address));


	initial begin
		clk = 1;
        clk_en = 1;
		rst = 1;
        start = 0;
        n = 0;
		dataa = 0;
		#1
		rst = 0;
	end

    initial begin
        //Block 0
        #1
        start = 1;
        n = 1;
        
        dataa = 32'h40800000; //4

        #2
        n = 2;
        dataa = 32'h41a00000; //20

        #2
        n = 3;
        dataa = 32'h41a00000; //20

        #2
        n = 1;
        dataa = 32'h40a00000; //5

        #2
        n = 2;
        dataa = 32'h3f800000; //1

        #2
        n = 3;
        dataa = 32'h40e00000; //7

        #2
        n = 1;
        dataa = 32'h40a00000; //5

        #2
        n = 2;
        dataa = 32'h3f800000; //1

        #2
        n = 3;
        dataa = 32'h3f800000; //1

        #2
        n = 2;
        dataa = 32'h40a00000; //5

        #2
        n = 3;
        dataa = 32'h40a00000; //5

        #2
        n = 2;
        dataa = 32'h40e00000; //7

        #2
        n = 2;
        dataa = 32'h428c0000; //70

        //Block 1
        #2
        n = 1;
        dataa = 32'h40800000; //4

        #2
        n = 2;
        dataa = 32'h41a00000; //20

        #2
        n = 3;
        dataa = 32'h41a00000; //20

        #2
        n = 1;
        dataa = 32'h40a00000; //5

        #2
        n = 2;
        dataa = 32'h3f800000; //1

        #2
        n = 3;
        dataa = 32'h40e00000; //7

        #2
        n = 1;
        dataa = 32'h40a00000; //5

        #2
        n = 2;
        dataa = 32'h3f800000; //1

        #2
        n = 3;
        dataa = 32'h3f800000; //1

        #2
        n = 2;
        dataa = 32'h40a00000; //5

        #2
        n = 3;
        dataa = 32'h40a00000; //5

        #2
        n = 2;
        dataa = 32'h40e00000; //7

        #2
        n = 2;
        dataa = 32'h428c0000; //70

        //Block 2
        #2
        n = 1;
        dataa = 32'h40800000; //4

        #2
        n = 2;
        dataa = 32'h41a00000; //20

        #2
        n = 3;
        dataa = 32'h41a00000; //20

        #2
        n = 1;
        dataa = 32'h40a00000; //5

        #2
        n = 2;
        dataa = 32'h3f800000; //1

        #2
        n = 3;
        dataa = 32'h40e00000; //7

        #2
        n = 1;
        dataa = 32'h40a00000; //5

        #2
        n = 2;
        dataa = 32'h3f800000; //1

        #2
        n = 3;
        dataa = 32'h3f800000; //1

        #2
        n = 2;
        dataa = 32'h40a00000; //5

        #2
        n = 3;
        dataa = 32'h40a00000; //5

        #2
        n = 2;
        dataa = 32'h40e00000; //7

        #2
        n = 2;
        dataa = 32'h428c0000; //70

        //Block 3
        #2
        n = 1;
        dataa = 32'h40800000; //4

        #2
        n = 2;
        dataa = 32'h41a00000; //20

        #2
        n = 3;
        dataa = 32'h41a00000; //20

        #2
        n = 1;
        dataa = 32'h40a00000; //5

        #2
        n = 2;
        dataa = 32'h3f800000; //1

        #2
        n = 3;
        dataa = 32'h40e00000; //7

        #2
        n = 1;
        dataa = 32'h40a00000; //5

        #2
        n = 2;
        dataa = 32'h3f800000; //1

        #2
        n = 3;
        dataa = 32'h3f800000; //1

        #2
        n = 2;
        dataa = 32'h40a00000; //5

        #2
        n = 3;
        dataa = 32'h40a00000; //5

        #2
        n = 2;
        dataa = 32'h40e00000; //7

        #2
        n = 2;
        dataa = 32'h428c0000; //70

        #2
        n = 4;
        start = 0;
        clk_en = 0;

        #10
        clk_en = 1;
        start = 1;
        
    end


    always #1 clk = ~clk;
		
	
endmodule