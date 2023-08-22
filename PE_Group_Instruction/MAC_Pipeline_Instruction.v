module MAC_Pipeline_Instruction(
    input clk,
    input clk_en,
    input reset,
    input start,
    input [31:0] dataa,
    output done,
    output [31:0] result
);

    wire NOPIn;
    wire [31:0] W_Data;
        
    wire NOPOut;
    wire [31:0] DataOut;

    assign NOPIn = ~start;
    assign done = ~NOPOut;
    assign result = DataOut;
    assign W_Data = dataa;

    MAC_Pipeline mac(
        .clk(clk), 
        .clk_en(clk_en), 
        .aclr(reset), 
        .NOPIn(NOPIn), 
        .NOPOut(NOPOut), 
        .W_Data(W_Data), 
        .I_Data(32'h40a00000), 
        .O_Data(32'h00000000), 
        .DataOut(DataOut));
endmodule
