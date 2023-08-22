module PE_31_Instruction
    #(parameter DataWidth = 32)(
    input clk,
    input clk_en,
    input reset,
    input start,
    output reg done,
    input [2:0] n,
    input [DataWidth - 1:0] dataa,
    output reg [DataWidth - 1:0] result);

    reg [1:0] Kernel_Address;
    reg [2:0] Input_Address;

    wire [4:0] INSTRUCTION;

    assign INSTRUCTION[0] = start && (n == 0); //reset
    assign INSTRUCTION[1] = start && (n == 1); //send weight
    assign INSTRUCTION[2] = start && (n == 2); //send input
    assign INSTRUCTION[3] = start && (n == 3); //send output
    assign INSTRUCTION[4] = (n == 4); //get result

    //ACC Connect Signals
    wire ACC_DataInValid;
    wire [DataWidth - 1:0] ACC_DataIn;
    wire ACC_DataOutValid;
    wire ACC_DataInRdy;
    wire ACC_DataOutRdy;
    wire [DataWidth - 1:0] ACC_DataOut;

    //Address Counter

    always @ (posedge clk) begin
        if(reset && clk_en) begin
            Kernel_Address <= 0;
        end
        else if(INSTRUCTION[1] && (Kernel_Address == 2) && clk_en) begin
            Kernel_Address <= 0;
        end
        else if(INSTRUCTION[1] && clk_en) begin
            Kernel_Address <= Kernel_Address + 1;
        end
        else begin
            Kernel_Address <= Kernel_Address;
        end

        if(reset && clk_en) begin
            Input_Address <= 0;
        end
        else if(INSTRUCTION[2] && (Input_Address == 2) && clk_en) begin
            Input_Address <= 0;
        end
        else if(INSTRUCTION[2] && clk_en) begin
            Input_Address <= Input_Address + 1;
        end
        else begin
            Input_Address <= Input_Address;
        end


    end

    //PE Connect Signals
    wire W_InValid [0:2][0:0];
    wire I_InValid [0:2][0:0];
    wire O_InValid [0:2][0:0];

    wire W_InRdy [0:2][0:0];
    wire I_InRdy [0:2][0:0];
    wire O_InRdy [0:2][0:0];

    wire [DataWidth - 1:0] W_In [0:2][0:0];
    wire [DataWidth - 1:0] I_In [0:2][0:0];
    wire [DataWidth - 1:0] O_In [0:2][0:0];

    wire [DataWidth - 1:0] W_Out [0:2][0:0];
    wire [DataWidth - 1:0] I_Out [0:2][0:0];
    wire [DataWidth - 1:0] O_Out [0:2][0:0];

    wire W_OutValid [0:2][0:0];
    wire I_OutValid [0:2][0:0];
    wire O_OutValid [0:2][0:0];

    wire W_OutRdy [0:2][0:0];
    wire I_OutRdy [0:2][0:0];
    wire O_OutRdy [0:2][0:0];

    //PEs

    //Column 0
    PE pe0_0(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[0][0]), .W_DataInRdy(W_InRdy[0][0]), .W_DataIn(W_In[0][0]),
        .W_DataOut(W_Out[0][0]), .W_DataOutValid(W_OutValid[0][0]), .W_DataOutRdy(W_OutRdy[0][0]),
        .I_DataInValid(I_InValid[0][0]), .I_DataInRdy(I_InRdy[0][0]), .I_DataIn(I_In[0][0]),
        .I_DataOut(I_Out[0][0]), .I_DataOutValid(I_OutValid[0][0]), .I_DataOutRdy(I_OutRdy[0][0]),
        .O_DataInValid(O_InValid[0][0]), .O_DataInRdy(O_InRdy[0][0]), .O_DataIn(O_In[0][0]),
        .O_DataOut(O_Out[0][0]), .O_DataOutValid(O_OutValid[0][0]), .O_DataOutRdy(O_OutRdy[0][0]));
    
    PE pe1_0(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[1][0]), .W_DataInRdy(W_InRdy[1][0]), .W_DataIn(W_In[1][0]),
        .W_DataOut(W_Out[1][0]), .W_DataOutValid(W_OutValid[1][0]), .W_DataOutRdy(W_OutRdy[1][0]),
        .I_DataInValid(I_InValid[1][0]), .I_DataInRdy(I_InRdy[1][0]), .I_DataIn(I_In[1][0]),
        .I_DataOut(I_Out[1][0]), .I_DataOutValid(I_OutValid[1][0]), .I_DataOutRdy(I_OutRdy[1][0]),
        .O_DataInValid(O_InValid[1][0]), .O_DataInRdy(O_InRdy[1][0]), .O_DataIn(O_In[1][0]),
        .O_DataOut(O_Out[1][0]), .O_DataOutValid(O_OutValid[1][0]), .O_DataOutRdy(O_OutRdy[1][0]));
    
    PE pe2_0(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[2][0]), .W_DataInRdy(W_InRdy[2][0]), .W_DataIn(W_In[2][0]),
        .W_DataOut(W_Out[2][0]), .W_DataOutValid(W_OutValid[2][0]), .W_DataOutRdy(W_OutRdy[2][0]),
        .I_DataInValid(I_InValid[2][0]), .I_DataInRdy(I_InRdy[2][0]), .I_DataIn(I_In[2][0]),
        .I_DataOut(I_Out[2][0]), .I_DataOutValid(I_OutValid[2][0]), .I_DataOutRdy(I_OutRdy[2][0]),
        .O_DataInValid(O_InValid[2][0]), .O_DataInRdy(O_InRdy[2][0]), .O_DataIn(O_In[2][0]),
        .O_DataOut(O_Out[2][0]), .O_DataOutValid(O_OutValid[2][0]), .O_DataOutRdy(O_OutRdy[2][0]));

    //ACC

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
    
    assign ACC_DataInValid = O_OutValid[2][0];

    assign ACC_DataIn = O_Out[2][0];

    assign ACC_DataOutRdy = INSTRUCTION[4];

    //Kernel
    assign W_InValid[0][0] = INSTRUCTION[1] && (Kernel_Address == 0);
    assign W_InValid[1][0] = INSTRUCTION[1] && (Kernel_Address == 1);
    assign W_InValid[2][0] = INSTRUCTION[1] && (Kernel_Address == 2);

    assign W_In[0][0] = dataa;
    assign W_In[1][0] = dataa;
    assign W_In[2][0] = dataa;

    assign W_OutRdy[0][0] = 1'b1;
    assign W_OutRdy[1][0] = 1'b1;
    assign W_OutRdy[2][0] = 1'b1;

    //Image
    assign I_InValid[0][0] = INSTRUCTION[2] && (Input_Address == 0);
    assign I_InValid[1][0] = INSTRUCTION[2] && (Input_Address == 1);
    assign I_InValid[2][0] = INSTRUCTION[2] && (Input_Address == 2);
    
    assign I_In[0][0] = dataa;
    assign I_In[1][0] = dataa;
    assign I_In[2][0] = dataa;


    assign I_OutRdy[0][0] = 1'b1;
    assign I_OutRdy[1][0] = 1'b1;
    assign I_OutRdy[2][0] = 1'b1;

    //Output
    assign O_InValid[0][0] = INSTRUCTION[3];
    assign O_InValid[1][0] = O_OutValid[0][0];
    assign O_InValid[2][0] = O_OutValid[1][0];

    assign O_In[0][0] = dataa;
    assign O_In[1][0] = O_Out[0][0];
    assign O_In[2][0] = O_Out[1][0];


    assign O_OutRdy[0][0] = O_InRdy[1][0];
    assign O_OutRdy[1][0] = O_InRdy[2][0];
    assign O_OutRdy[2][0] = ACC_DataInRdy;

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
            done = ACC_DataOutValid;
            result = ACC_DataOut;
        end
        else begin
            done = 1'b0;
            result = 32'b0;
        end
    end


endmodule
