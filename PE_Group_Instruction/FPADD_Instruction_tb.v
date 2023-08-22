`timescale 1ps/1ps
module FPADD_Instruction_tb();

    reg clk;
    reg reset;
    reg clk_en;
    reg start;

    reg [31:0] dataa;
    reg [31:0] datab;
    wire [31:0] result;
    wire done;

    FPADD_Instruction dut(
        .clk(clk),
        .reset(reset),
        .clk_en(clk_en),
        .start(start),
        .done(done),
        .dataa(dataa),
        .datab(datab),
        .result(result)
    );

	initial begin
		clk = 1;
        clk_en = 1;
		reset = 1;
        start = 0;
		dataa = 0;
        datab = 0;
		#1
		reset = 0;
        start = 1;
        dataa = 32'h40a00000; //5
        datab = 32'h41200000; //10
	end

    always #1 clk = ~clk;
    
endmodule
