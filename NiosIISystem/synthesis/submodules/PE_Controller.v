//used to controller edge dataflow
module PE_Controller
	#(	parameter W_PEGroupSize = 4,
		parameter O_PEGroupSize = 4,
		parameter I_PEGroupSize = W_PEGroupSize + O_PEGroupSize - 1,
		parameter W_PEAddrWidth = 2,
		parameter O_PEAddrWidth = 2,
		parameter I_PEAddrWidth = 3,
		parameter BlockCount = 4,
		parameter BlockCountWidth = 3)
		(clk, clk_en, aclr, sclr, EN_W, EN_I, EN_O_In, EN_O_Out,
		W_PEAddr, I_PEAddr, O_In_PEAddr, O_Out_PEAddr,
		O_IN_BLOCK_EQUAL_TO_ZERO, O_IN_BLOCK_MORE_THAN_BLOCK_COUNT);

	input clk, clk_en, aclr, sclr;
	input EN_W, EN_I, EN_O_In, EN_O_Out;
	output [W_PEAddrWidth - 1 : 0] W_PEAddr;
	output [I_PEAddrWidth - 1 : 0] I_PEAddr;
	output [O_PEAddrWidth - 1 : 0] O_In_PEAddr;
	output [O_PEAddrWidth - 1 : 0] O_Out_PEAddr;

	reg [BlockCountWidth - 1: 0] I_Block_Counter;
	reg [BlockCountWidth - 1: 0] O_In_Block_Counter;
	reg [BlockCountWidth - 1: 0] O_Out_Block_Counter;

  	Pointer #(.BufferWidth(W_PEAddrWidth)) WeightAddrUnit
	(.clk(clk), .clk_en(clk_en), .aclr(aclr), .sclr(sclr || (EN_W && W_PEAddr == W_PEGroupSize - 1)), .EN(EN_W), .Pointer(W_PEAddr));

	Pointer #(.BufferWidth(I_PEAddrWidth)) InputAddrUnit
	(.clk(clk), .clk_en(clk_en), .aclr(aclr), .sclr(sclr || (EN_I && I_PEAddr == I_PEGroupSize - 1)), .EN(EN_I), .Pointer(I_PEAddr));

	Pointer #(.BufferWidth(O_PEAddrWidth)) OutputInAddrUnit
	(.clk(clk), .clk_en(clk_en), .aclr(aclr), .sclr(sclr || (EN_O_In && O_In_PEAddr == O_PEGroupSize - 1)), .EN(EN_O_In), .Pointer(O_In_PEAddr));
	
	Pointer #(.BufferWidth(O_PEAddrWidth)) OutputOutAddrUnit
	(.clk(clk), .clk_en(clk_en), .aclr(aclr), .sclr(sclr || (EN_O_Out && O_Out_PEAddr == O_PEGroupSize - 1)), .EN(EN_O_Out), .Pointer(O_Out_PEAddr));


	//status signals
	output O_IN_BLOCK_EQUAL_TO_ZERO, O_IN_BLOCK_MORE_THAN_BLOCK_COUNT;
	wire O_IN_BLOCK_EQUAL_TO_BLOCK_COUNT;
	assign O_IN_BLOCK_EQUAL_TO_ZERO = (O_In_Block_Counter == 0);
	assign O_IN_BLOCK_EQUAL_TO_BLOCK_COUNT = (O_In_Block_Counter == BlockCount - 1);
	assign O_IN_BLOCK_MORE_THAN_BLOCK_COUNT = (O_In_Block_Counter == BlockCount);
	wire O_IN_PEADDR_EQUAL_TO_O_GROUP_SIZE = (O_In_PEAddr == O_PEGroupSize - 1);

	//end of status signals
	
	always@(posedge clk, posedge aclr) begin
		if(aclr) begin
			O_In_Block_Counter = 0;
		end
		else if (sclr && clk_en) begin
			O_In_Block_Counter <= 0;
		end
		else if (EN_I && O_IN_PEADDR_EQUAL_TO_O_GROUP_SIZE && O_IN_BLOCK_EQUAL_TO_BLOCK_COUNT && clk_en) begin
			O_In_Block_Counter <= 0;
		end
		else if (EN_I && O_IN_PEADDR_EQUAL_TO_O_GROUP_SIZE && clk_en) begin
			O_In_Block_Counter <= O_In_Block_Counter + 1'b1;
		end
		else begin
			O_In_Block_Counter <= O_In_Block_Counter;
		end
	end
	
endmodule
