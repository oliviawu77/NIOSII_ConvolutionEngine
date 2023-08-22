module Pointer
    #(  parameter BufferWidth = 2)
    (clk, clk_en, aclr, sclr, EN, Pointer);
    input clk, clk_en, aclr, sclr;
    input EN;

    output reg [BufferWidth-1:0] Pointer;

    always@(posedge clk, posedge aclr)begin
	 
        if(aclr) begin
            Pointer = 0;
        end
        else if (sclr && clk_en) begin
            Pointer <= 0;
        end
        else if(EN && clk_en) begin
	        Pointer <= Pointer + 1'b1;
        end
        else begin
           Pointer <= Pointer; 
        end
    end
endmodule