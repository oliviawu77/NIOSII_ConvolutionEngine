module FPMUL_Instruction(
    clk,
    reset,
    clk_en,
    start,
    dataa,
    datab,
    result
);
    input clk, reset, clk_en;
    input start;

    input [31:0] dataa, datab;
    output [31:0] result;

    FPMUL fpmul(
        .aclr(reset),
	    .clk_en(clk_en),
	    .clock(clk),
	    .dataa(dataa),
	    .datab(datab),
	    .result(result));

endmodule
