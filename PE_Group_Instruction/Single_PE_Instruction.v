module Single_PE_Instruction
    #(parameter DataWidth = 32)(
    input clk,
    input clk_en,
    input reset,
    input start,
    output reg done,
    input [2:0] n,
    input [DataWidth - 1:0] dataa,
    output reg [DataWidth - 1:0] result);

    wire [4:0] INSTRUCTION;

    assign INSTRUCTION[0] = start && (n == 0); //reset
    assign INSTRUCTION[1] = start && (n == 1); //send weight
    assign INSTRUCTION[2] = start && (n == 2); //send input
    assign INSTRUCTION[3] = start && (n == 3); //send output
    assign INSTRUCTION[4] = (n == 4); //get result

    //ACC Connect Signals
    /*
    wire ACC_DataInValid;
    wire [DataWidth - 1:0] ACC_DataIn;
    wire ACC_DataOutValid;
    wire ACC_DataInRdy;
    wire ACC_DataOutRdy;
    wire [DataWidth - 1:0] ACC_DataOut;
    */

    //PE Connect Signals
    wire W_InValid;
    wire I_InValid;
    wire O_InValid;

    wire W_InRdy;
    wire I_InRdy;
    wire O_InRdy;

    wire [DataWidth - 1:0] W_In;
    wire [DataWidth - 1:0] I_In;
    wire [DataWidth - 1:0] O_In;

    wire [DataWidth - 1:0] W_Out;
    wire [DataWidth - 1:0] I_Out;
    wire [DataWidth - 1:0] O_Out;

    wire W_OutValid;
    wire I_OutValid;
    wire O_OutValid;

    wire W_OutRdy;
    wire I_OutRdy;
    wire O_OutRdy;

    //PEs

    //Column 0
    PE pe0_0(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid), .W_DataInRdy(W_InRdy), .W_DataIn(W_In),
        .W_DataOut(W_Out), .W_DataOutValid(W_OutValid), .W_DataOutRdy(W_OutRdy),
        .I_DataInValid(I_InValid), .I_DataInRdy(I_InRdy), .I_DataIn(I_In),
        .I_DataOut(I_Out), .I_DataOutValid(I_OutValid), .I_DataOutRdy(I_OutRdy),
        .O_DataInValid(O_InValid), .O_DataInRdy(O_InRdy), .O_DataIn(O_In),
        .O_DataOut(O_Out), .O_DataOutValid(O_OutValid), .O_DataOutRdy(O_OutRdy));
    
    //ACC
    /*
    ACC #(.DataWidth(32),
		.Pipeline_Stages(7),
		.NOPCount(9),
		.NOPCountWidth(4),
        .BufferWidth(2),
        .BufferSize(4))
    acc0 (  .clk(clk), .clk_en(clk_en), .aclr(reset), .sclr(reset), 
            .DataInValid(ACC_DataInValid), .DataIn(ACC_DataIn), 
            .DataOutValid(ACC_DataOutValid), .DataInRdy(ACC_DataInRdy), 
            .DataOutRdy(ACC_DataOutRdy), .DataOut(ACC_DataOut));
    
    
    assign ACC_DataInValid = O_OutValid;

    assign ACC_DataIn = O_Out;

    assign ACC_DataOutRdy = INSTRUCTION[4];
    */

    //Kernel
    assign W_InValid = INSTRUCTION[1];

    assign W_In = dataa;
    
    assign W_OutRdy = 1'b1;

    //Image
    assign I_InValid = INSTRUCTION[2];
    
    assign I_In = dataa;

    assign I_OutRdy = 1'b1;

    //Output
    assign O_InValid = INSTRUCTION[3];

    assign O_In = dataa;

    //assign O_OutRdy = ACC_DataInRdy;
    assign O_OutRdy = INSTRUCTION[4];

    always @ (*) begin
        if(INSTRUCTION[0]) begin
            done = start;
            result = 32'b0;
        end
        else if(INSTRUCTION[1]) begin
            done = start;
            result = 32'b0;
        end
        else if(INSTRUCTION[2]) begin
            done = start;
            result = 32'b0;
        end
        else if(INSTRUCTION[3]) begin
            done = start;
            result = 32'b0;
        end
        else if(INSTRUCTION[4]) begin
            done = O_OutValid;
            //done = ACC_DataOutValid;
            result = O_Out;
            //result = ACC_DataOut;
        end
        else begin
            done = 1'b0;
            result = 32'b0;
        end
    end


endmodule
