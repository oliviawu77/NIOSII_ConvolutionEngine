`timescale 1ns/1ns
module Single_PE_Instruction_tb();
    
	reg clk, clk_en, rst;
    reg start;
    reg [2:0] n;
	reg [31:0] dataa;
	
	wire [31:0] result;
    wire done;

    Single_PE_Instruction dut
	( .clk(clk), .clk_en(clk_en), .reset(rst), .start(start), .n(n), .done(done), .dataa(dataa), .result(result));


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

    integer i;

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

        //Block 4
        #2   
        n = 1;
        dataa = 32'h40800000; //4
        #2
        n = 2;
        dataa = 32'h41a00000; //20
        #2
        n = 3;
        dataa = 32'h41a00000; //20  

        //Block 5
        #2   
        n = 1;
        dataa = 32'h40800000; //4
        #2
        n = 2;
        dataa = 32'h41a00000; //20
        #2
        n = 3;
        dataa = 32'h41a00000; //20

        //Block 6
        #2   
        n = 1;
        dataa = 32'h40800000; //4
        #2
        n = 2;
        dataa = 32'h41a00000; //20
        #2
        n = 3;
        dataa = 32'h41a00000; //20

        //Block 7
        #2   
        n = 1;
        dataa = 32'h40800000; //4
        #2
        n = 2;
        dataa = 32'h41a00000; //20
        #2
        n = 3;
        dataa = 32'h41a00000; //20 

        //Block 8
        #2   
        n = 1;
        dataa = 32'h40800000; //4
        #2
        n = 2;
        dataa = 32'h41a00000; //20
        #2
        n = 3;
        dataa = 32'h41a00000; //20

        //Block 9
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
        n = 4;
        clk_en = 1;
        
    end


    always #1 clk = ~clk;
		
	
endmodule