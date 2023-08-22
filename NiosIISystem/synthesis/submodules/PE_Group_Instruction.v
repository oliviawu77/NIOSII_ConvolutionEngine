module PE_Group_Instruction 
	#(	parameter DataWidth = 32) 
	(clk, clk_en, rst, start, done, n, dataa, result);
    
	input clk, clk_en, rst;
    input start;
    input [2:0] n;
    output reg done;

	input [DataWidth - 1 : 0] dataa;
	
	output reg [DataWidth - 1: 0] result;
        
    wire O_DataOutValid;
	wire W_DataInRdy;
	wire I_DataInRdy;
	wire O_DataInRdy;

	wire W_DataInValid;
	wire I_DataInValid;
	wire O_DataInValid;

    wire O_DataOutRdy;

    wire [DataWidth - 1:0] O_DataOut;

    assign W_DataInValid = start && (n == 1);
    assign I_DataInValid = start && (n == 2);
    assign O_DataInValid = start && (n == 3);

    assign O_DataOutRdy = (n == 4);
    
    always @ (*) begin
        if(n == 0) begin
            done = 1;
        end
        else if(n == 1) begin
            done = W_DataInRdy;
        end
        else if(n == 2) begin
            done = I_DataInRdy;
        end
        else if(n == 3) begin
            done = O_DataInRdy;
        end
        else if(n == 4) begin
            //done = 1;
            done = O_DataOutValid;
        end
        else begin
            done = 0;
        end
    end
    

    
    always @(*) begin
        if(n == 1 || n == 2 || n == 3) begin
            result = dataa;
        end
        else if(n == 4) begin
            result = O_DataOut;
        end
        else begin
            result = 0;
        end 
    end

    
	PE_Group dut(.clk(clk), .clk_en(clk_en), .aclr(rst || (n == 0)),
		.W_DataInValid(W_DataInValid), .W_DataInRdy(W_DataInRdy), .W_DataIn(dataa),
		.I_DataInValid(I_DataInValid), .I_DataInRdy(I_DataInRdy), .I_DataIn(dataa),
		.O_DataInValid(O_DataInValid), .O_DataInRdy(O_DataInRdy), .O_DataIn(dataa),
		.O_DataOutValid(O_DataOutValid), .O_DataOutRdy(O_DataOutRdy), .O_DataOut(O_DataOut));
    
endmodule