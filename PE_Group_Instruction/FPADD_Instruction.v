module FPADD_Instruction(
    clk,
    reset,
    clk_en,
    start,
    done,
    dataa,
    datab,
    result
);
    input clk;
    input reset;
    input clk_en;
    input start;

    input [31:0] dataa;
    input [31:0] datab;
    output [31:0] result;
    output done;
    
    /*
    always @ (posedge clk) begin
        if(reset) begin
            result <= 0;
            done <= 0;
        end
        else if(start && clk_en) begin
            result <= dataa + datab;
            done <= 1;
        end
        else begin
            result <= 0;
            done <= 0;
        end
    end
    
    
    assign result = dataa + datab;
    */
    FPADD4 fpadd(
        .aclr(reset),
        .clk_en(clk_en),
        .clock(clk),
        .dataa(dataa),
        .datab(datab),
        .result(result));

	ValidPipeline #(.Stages(10)) ADD_Valid_Unit
    	(.clk(clk),
		.clk_en(clk_en),
        .aclr(reset),
        .ValidIn(start), 
        .ValidOut(done));

endmodule
