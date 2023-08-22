module MAC_Pipeline
    #(  parameter DataWidth = 32,
        parameter MUL_Pipeline_Stages = 5,
        parameter ADD_Pipeline_Stages = 7,
        parameter Pipeline_Stages = MUL_Pipeline_Stages + ADD_Pipeline_Stages)
    ( clk, clk_en, aclr, NOPIn, NOPOut, W_Data, I_Data, O_Data, DataOut);
    input clk, clk_en, aclr, NOPIn;
    input [DataWidth-1:0] W_Data, I_Data, O_Data;
        
    output NOPOut;
    output [DataWidth-1:0] DataOut;
    
    wire [DataWidth-1:0] MulResult;
    wire [DataWidth-1:0] O_Data_Pipeline_Out;
    //32-bit FP mul (5 Stages)
    FPMUL FP_MulPipelineUnit(
        .aclr(aclr),
        .clock(clk),
		  .clk_en(clk_en),
        .dataa(W_Data),
        .datab(I_Data),
        .result(MulResult));
    //32-bit FP add (7 Stages)
    FPADD FP_AddUnit(
        .aclr(aclr),
        .clock(clk),
		  .clk_en(clk_en),
        .dataa(MulResult),
        .datab(O_Data_Pipeline_Out),
        .result(DataOut));

    NOPPipeline #(.Stages(Pipeline_Stages)) NOPPipelineUnit
        (.clk(clk),
			.clk_en(clk_en),
        .aclr(aclr),
        .NOPIn(NOPIn), 
        .NOPOut(NOPOut));

    OutputDataPipeline #(.DataWidth(DataWidth), .Stages(MUL_Pipeline_Stages)) OutputDataPipelineUnit
        (.clk(clk),
			.clk_en(clk_en),
        .aclr(aclr), 
        .DataIn(O_Data),
        .DataOut(O_Data_Pipeline_Out));

endmodule
