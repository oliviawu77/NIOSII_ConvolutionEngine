module FIFO_Buffer_ACC_Instruction(
    input clk,
    input clk_en,
    input reset,
    input start,
    input [1:0] n,
    input [31:0] dataa,
    output done,
    output [31:0] result
);

    wire Pop;
    wire Push;
    wire [31:0]DataIn;
    wire Empty;
    wire Full;
    wire [31:0] DataOut;

    assign Push = (n == 1);
    assign Pop = (n == 2);
    assign DataIn = dataa;
    assign result = DataOut;


    FIFO_Buffer_ACC fifo(
        .clk(clk), 
        .clk_en(clk_en), 
        .aclr(reset), 
        .Pop(Pop), 
        .Push(Push), 
        .DataIn(DataIn), 
        .Empty(Empty), 
        .Full(Full), 
        .DataOut(DataOut));
    
endmodule
