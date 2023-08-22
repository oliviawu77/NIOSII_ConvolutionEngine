module PE_94_Instruction
    #(parameter DataWidth = 32)(
    input clk,
    input clk_en,
    input reset,
    input start,
    output reg done,
    input [2:0] n,
    input [DataWidth - 1:0] dataa,
    output reg [DataWidth - 1:0] result);

    reg [3:0] Kernel_Address;
    reg [3:0] Input_Address;
    reg [1:0] Output_Write_Address;
    reg [1:0] Output_Read_Address;

    wire [4:0] INSTRUCTION;

    assign INSTRUCTION[0] = start && (n == 0); //reset
    assign INSTRUCTION[1] = start && (n == 1); //send weight
    assign INSTRUCTION[2] = start && (n == 2); //send input
    assign INSTRUCTION[3] = start && (n == 3); //send output
    assign INSTRUCTION[4] = (n == 4); //get result

    //ACC Connect Signals
    wire [3:0] ACC_DataInValid;
    wire [DataWidth - 1:0] ACC_DataIn [0:3];
    wire [3:0] ACC_DataOutValid;
    wire [3:0] ACC_DataInRdy;
    wire [3:0] ACC_DataOutRdy;
    wire [DataWidth - 1:0] ACC_DataOut [0:3];

    //Address Counter

    always @ (posedge clk) begin
        if(reset && clk_en) begin
            Kernel_Address <= 0;
        end
        else if(INSTRUCTION[1] && (Kernel_Address == 8) && clk_en) begin
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
        else if(INSTRUCTION[2] && (Input_Address == 11) && clk_en) begin
            Input_Address <= 0;
        end
        else if(INSTRUCTION[2] && clk_en) begin
            Input_Address <= Input_Address + 1;
        end
        else begin
            Input_Address <= Input_Address;
        end

        if(reset && clk_en) begin
            Output_Write_Address <= 0;
        end
        else if(INSTRUCTION[3] && (Output_Write_Address == 3) && clk_en) begin
            Output_Write_Address <= 0;
        end
        else if(INSTRUCTION[3] && clk_en) begin
            Output_Write_Address <= Output_Write_Address + 1;
        end
        else begin
            Output_Write_Address <= Output_Write_Address;
        end

        if(reset && clk_en) begin
            Output_Read_Address <= 0;
        end
        else if(INSTRUCTION[4] && ACC_DataOutValid[3] && (Output_Read_Address == 3) && clk_en) begin
            Output_Read_Address <= 0;
        end
        else if(INSTRUCTION[4] && (ACC_DataOutValid[0] || ACC_DataOutValid[1] || ACC_DataOutValid[2]) && clk_en) begin
            Output_Read_Address <= Output_Read_Address + 1;
        end
        else begin
            Output_Read_Address <= Output_Read_Address;
        end

    end

    //PE Connect Signals
    wire W_InValid [0:8][0:3];
    wire I_InValid [0:8][0:3];
    wire O_InValid [0:8][0:3];

    wire W_InRdy [0:8][0:3];
    wire I_InRdy [0:8][0:3];
    wire O_InRdy [0:8][0:3];

    wire [DataWidth - 1:0] W_In [0:8][0:3];
    wire [DataWidth - 1:0] I_In [0:8][0:3];
    wire [DataWidth - 1:0] O_In [0:8][0:3];

    wire [DataWidth - 1:0] W_Out [0:8][0:3];
    wire [DataWidth - 1:0] I_Out [0:8][0:3];
    wire [DataWidth - 1:0] O_Out [0:8][0:3];

    wire W_OutValid [0:8][0:3];
    wire I_OutValid [0:8][0:3];
    wire O_OutValid [0:8][0:3];

    wire W_OutRdy [0:8][0:3];
    wire I_OutRdy [0:8][0:3];
    wire O_OutRdy [0:8][0:3];

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
        
    PE pe3_0(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[3][0]), .W_DataInRdy(W_InRdy[3][0]), .W_DataIn(W_In[3][0]),
        .W_DataOut(W_Out[3][0]), .W_DataOutValid(W_OutValid[3][0]), .W_DataOutRdy(W_OutRdy[3][0]),
        .I_DataInValid(I_InValid[3][0]), .I_DataInRdy(I_InRdy[3][0]), .I_DataIn(I_In[3][0]),
        .I_DataOut(I_Out[3][0]), .I_DataOutValid(I_OutValid[3][0]), .I_DataOutRdy(I_OutRdy[3][0]),
        .O_DataInValid(O_InValid[3][0]), .O_DataInRdy(O_InRdy[3][0]), .O_DataIn(O_In[3][0]),
        .O_DataOut(O_Out[3][0]), .O_DataOutValid(O_OutValid[3][0]), .O_DataOutRdy(O_OutRdy[3][0]));

    PE pe4_0(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[4][0]), .W_DataInRdy(W_InRdy[4][0]), .W_DataIn(W_In[4][0]),
        .W_DataOut(W_Out[4][0]), .W_DataOutValid(W_OutValid[4][0]), .W_DataOutRdy(W_OutRdy[4][0]),
        .I_DataInValid(I_InValid[4][0]), .I_DataInRdy(I_InRdy[4][0]), .I_DataIn(I_In[4][0]),
        .I_DataOut(I_Out[4][0]), .I_DataOutValid(I_OutValid[4][0]), .I_DataOutRdy(I_OutRdy[4][0]),
        .O_DataInValid(O_InValid[4][0]), .O_DataInRdy(O_InRdy[4][0]), .O_DataIn(O_In[4][0]),
        .O_DataOut(O_Out[4][0]), .O_DataOutValid(O_OutValid[4][0]), .O_DataOutRdy(O_OutRdy[4][0]));

    PE pe5_0(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[5][0]), .W_DataInRdy(W_InRdy[5][0]), .W_DataIn(W_In[5][0]),
        .W_DataOut(W_Out[5][0]), .W_DataOutValid(W_OutValid[5][0]), .W_DataOutRdy(W_OutRdy[5][0]),
        .I_DataInValid(I_InValid[5][0]), .I_DataInRdy(I_InRdy[5][0]), .I_DataIn(I_In[5][0]),
        .I_DataOut(I_Out[5][0]), .I_DataOutValid(I_OutValid[5][0]), .I_DataOutRdy(I_OutRdy[5][0]),
        .O_DataInValid(O_InValid[5][0]), .O_DataInRdy(O_InRdy[5][0]), .O_DataIn(O_In[5][0]),
        .O_DataOut(O_Out[5][0]), .O_DataOutValid(O_OutValid[5][0]), .O_DataOutRdy(O_OutRdy[5][0]));

    PE pe6_0(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[6][0]), .W_DataInRdy(W_InRdy[6][0]), .W_DataIn(W_In[6][0]),
        .W_DataOut(W_Out[6][0]), .W_DataOutValid(W_OutValid[6][0]), .W_DataOutRdy(W_OutRdy[6][0]),
        .I_DataInValid(I_InValid[6][0]), .I_DataInRdy(I_InRdy[6][0]), .I_DataIn(I_In[6][0]),
        .I_DataOut(I_Out[6][0]), .I_DataOutValid(I_OutValid[6][0]), .I_DataOutRdy(I_OutRdy[6][0]),
        .O_DataInValid(O_InValid[6][0]), .O_DataInRdy(O_InRdy[6][0]), .O_DataIn(O_In[6][0]),
        .O_DataOut(O_Out[6][0]), .O_DataOutValid(O_OutValid[6][0]), .O_DataOutRdy(O_OutRdy[6][0]));

    PE pe7_0(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[7][0]), .W_DataInRdy(W_InRdy[7][0]), .W_DataIn(W_In[7][0]),
        .W_DataOut(W_Out[7][0]), .W_DataOutValid(W_OutValid[7][0]), .W_DataOutRdy(W_OutRdy[7][0]),
        .I_DataInValid(I_InValid[7][0]), .I_DataInRdy(I_InRdy[7][0]), .I_DataIn(I_In[7][0]),
        .I_DataOut(I_Out[7][0]), .I_DataOutValid(I_OutValid[7][0]), .I_DataOutRdy(I_OutRdy[7][0]),
        .O_DataInValid(O_InValid[7][0]), .O_DataInRdy(O_InRdy[7][0]), .O_DataIn(O_In[7][0]),
        .O_DataOut(O_Out[7][0]), .O_DataOutValid(O_OutValid[7][0]), .O_DataOutRdy(O_OutRdy[7][0]));

    PE pe8_0(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[8][0]), .W_DataInRdy(W_InRdy[8][0]), .W_DataIn(W_In[8][0]),
        .W_DataOut(W_Out[8][0]), .W_DataOutValid(W_OutValid[8][0]), .W_DataOutRdy(W_OutRdy[8][0]),
        .I_DataInValid(I_InValid[8][0]), .I_DataInRdy(I_InRdy[8][0]), .I_DataIn(I_In[8][0]),
        .I_DataOut(I_Out[8][0]), .I_DataOutValid(I_OutValid[8][0]), .I_DataOutRdy(I_OutRdy[8][0]),
        .O_DataInValid(O_InValid[8][0]), .O_DataInRdy(O_InRdy[8][0]), .O_DataIn(O_In[8][0]),
        .O_DataOut(O_Out[8][0]), .O_DataOutValid(O_OutValid[8][0]), .O_DataOutRdy(O_OutRdy[8][0]));

    //Column 1
    PE pe0_1(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[0][1]), .W_DataInRdy(W_InRdy[0][1]), .W_DataIn(W_In[0][1]),
        .W_DataOut(W_Out[0][1]), .W_DataOutValid(W_OutValid[0][1]), .W_DataOutRdy(W_OutRdy[0][1]),
        .I_DataInValid(I_InValid[0][1]), .I_DataInRdy(I_InRdy[0][1]), .I_DataIn(I_In[0][1]),
        .I_DataOut(I_Out[0][1]), .I_DataOutValid(I_OutValid[0][1]), .I_DataOutRdy(I_OutRdy[0][1]),
        .O_DataInValid(O_InValid[0][1]), .O_DataInRdy(O_InRdy[0][1]), .O_DataIn(O_In[0][1]),
        .O_DataOut(O_Out[0][1]), .O_DataOutValid(O_OutValid[0][1]), .O_DataOutRdy(O_OutRdy[0][1]));
    
    PE pe1_1(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[1][1]), .W_DataInRdy(W_InRdy[1][1]), .W_DataIn(W_In[1][1]),
        .W_DataOut(W_Out[1][1]), .W_DataOutValid(W_OutValid[1][1]), .W_DataOutRdy(W_OutRdy[1][1]),
        .I_DataInValid(I_InValid[1][1]), .I_DataInRdy(I_InRdy[1][1]), .I_DataIn(I_In[1][1]),
        .I_DataOut(I_Out[1][1]), .I_DataOutValid(I_OutValid[1][1]), .I_DataOutRdy(I_OutRdy[1][1]),
        .O_DataInValid(O_InValid[1][1]), .O_DataInRdy(O_InRdy[1][1]), .O_DataIn(O_In[1][1]),
        .O_DataOut(O_Out[1][1]), .O_DataOutValid(O_OutValid[1][1]), .O_DataOutRdy(O_OutRdy[1][1]));
    
    PE pe2_1(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[2][1]), .W_DataInRdy(W_InRdy[2][1]), .W_DataIn(W_In[2][1]),
        .W_DataOut(W_Out[2][1]), .W_DataOutValid(W_OutValid[2][1]), .W_DataOutRdy(W_OutRdy[2][1]),
        .I_DataInValid(I_InValid[2][1]), .I_DataInRdy(I_InRdy[2][1]), .I_DataIn(I_In[2][1]),
        .I_DataOut(I_Out[2][1]), .I_DataOutValid(I_OutValid[2][1]), .I_DataOutRdy(I_OutRdy[2][1]),
        .O_DataInValid(O_InValid[2][1]), .O_DataInRdy(O_InRdy[2][1]), .O_DataIn(O_In[2][1]),
        .O_DataOut(O_Out[2][1]), .O_DataOutValid(O_OutValid[2][1]), .O_DataOutRdy(O_OutRdy[2][1]));

    PE pe3_1(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[3][1]), .W_DataInRdy(W_InRdy[3][1]), .W_DataIn(W_In[3][1]),
        .W_DataOut(W_Out[3][1]), .W_DataOutValid(W_OutValid[3][1]), .W_DataOutRdy(W_OutRdy[3][1]),
        .I_DataInValid(I_InValid[3][1]), .I_DataInRdy(I_InRdy[3][1]), .I_DataIn(I_In[3][1]),
        .I_DataOut(I_Out[3][1]), .I_DataOutValid(I_OutValid[3][1]), .I_DataOutRdy(I_OutRdy[3][1]),
        .O_DataInValid(O_InValid[3][1]), .O_DataInRdy(O_InRdy[3][1]), .O_DataIn(O_In[3][1]),
        .O_DataOut(O_Out[3][1]), .O_DataOutValid(O_OutValid[3][1]), .O_DataOutRdy(O_OutRdy[3][1]));

    PE pe4_1(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[4][1]), .W_DataInRdy(W_InRdy[4][1]), .W_DataIn(W_In[4][1]),
        .W_DataOut(W_Out[4][1]), .W_DataOutValid(W_OutValid[4][1]), .W_DataOutRdy(W_OutRdy[4][1]),
        .I_DataInValid(I_InValid[4][1]), .I_DataInRdy(I_InRdy[4][1]), .I_DataIn(I_In[4][1]),
        .I_DataOut(I_Out[4][1]), .I_DataOutValid(I_OutValid[4][1]), .I_DataOutRdy(I_OutRdy[4][1]),
        .O_DataInValid(O_InValid[4][1]), .O_DataInRdy(O_InRdy[4][1]), .O_DataIn(O_In[4][1]),
        .O_DataOut(O_Out[4][1]), .O_DataOutValid(O_OutValid[4][1]), .O_DataOutRdy(O_OutRdy[4][1]));

    PE pe5_1(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[5][1]), .W_DataInRdy(W_InRdy[5][1]), .W_DataIn(W_In[5][1]),
        .W_DataOut(W_Out[5][1]), .W_DataOutValid(W_OutValid[5][1]), .W_DataOutRdy(W_OutRdy[5][1]),
        .I_DataInValid(I_InValid[5][1]), .I_DataInRdy(I_InRdy[5][1]), .I_DataIn(I_In[5][1]),
        .I_DataOut(I_Out[5][1]), .I_DataOutValid(I_OutValid[5][1]), .I_DataOutRdy(I_OutRdy[5][1]),
        .O_DataInValid(O_InValid[5][1]), .O_DataInRdy(O_InRdy[5][1]), .O_DataIn(O_In[5][1]),
        .O_DataOut(O_Out[5][1]), .O_DataOutValid(O_OutValid[5][1]), .O_DataOutRdy(O_OutRdy[5][1]));

    PE pe6_1(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[6][1]), .W_DataInRdy(W_InRdy[6][1]), .W_DataIn(W_In[6][1]),
        .W_DataOut(W_Out[6][1]), .W_DataOutValid(W_OutValid[6][1]), .W_DataOutRdy(W_OutRdy[6][1]),
        .I_DataInValid(I_InValid[6][1]), .I_DataInRdy(I_InRdy[6][1]), .I_DataIn(I_In[6][1]),
        .I_DataOut(I_Out[6][1]), .I_DataOutValid(I_OutValid[6][1]), .I_DataOutRdy(I_OutRdy[6][1]),
        .O_DataInValid(O_InValid[6][1]), .O_DataInRdy(O_InRdy[6][1]), .O_DataIn(O_In[6][1]),
        .O_DataOut(O_Out[6][1]), .O_DataOutValid(O_OutValid[6][1]), .O_DataOutRdy(O_OutRdy[6][1]));

    PE pe7_1(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[7][1]), .W_DataInRdy(W_InRdy[7][1]), .W_DataIn(W_In[7][1]),
        .W_DataOut(W_Out[7][1]), .W_DataOutValid(W_OutValid[7][1]), .W_DataOutRdy(W_OutRdy[7][1]),
        .I_DataInValid(I_InValid[7][1]), .I_DataInRdy(I_InRdy[7][1]), .I_DataIn(I_In[7][1]),
        .I_DataOut(I_Out[7][1]), .I_DataOutValid(I_OutValid[7][1]), .I_DataOutRdy(I_OutRdy[7][1]),
        .O_DataInValid(O_InValid[7][1]), .O_DataInRdy(O_InRdy[7][1]), .O_DataIn(O_In[7][1]),
        .O_DataOut(O_Out[7][1]), .O_DataOutValid(O_OutValid[7][1]), .O_DataOutRdy(O_OutRdy[7][1]));

    PE pe8_1(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[8][1]), .W_DataInRdy(W_InRdy[8][1]), .W_DataIn(W_In[8][1]),
        .W_DataOut(W_Out[8][1]), .W_DataOutValid(W_OutValid[8][1]), .W_DataOutRdy(W_OutRdy[8][1]),
        .I_DataInValid(I_InValid[8][1]), .I_DataInRdy(I_InRdy[8][1]), .I_DataIn(I_In[8][1]),
        .I_DataOut(I_Out[8][1]), .I_DataOutValid(I_OutValid[8][1]), .I_DataOutRdy(I_OutRdy[8][1]),
        .O_DataInValid(O_InValid[8][1]), .O_DataInRdy(O_InRdy[8][1]), .O_DataIn(O_In[8][1]),
        .O_DataOut(O_Out[8][1]), .O_DataOutValid(O_OutValid[8][1]), .O_DataOutRdy(O_OutRdy[8][1]));

    //Column 2
    PE pe0_2(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[0][2]), .W_DataInRdy(W_InRdy[0][2]), .W_DataIn(W_In[0][2]),
        .W_DataOut(W_Out[0][2]), .W_DataOutValid(W_OutValid[0][2]), .W_DataOutRdy(W_OutRdy[0][2]),
        .I_DataInValid(I_InValid[0][2]), .I_DataInRdy(I_InRdy[0][2]), .I_DataIn(I_In[0][2]),
        .I_DataOut(I_Out[0][2]), .I_DataOutValid(I_OutValid[0][2]), .I_DataOutRdy(I_OutRdy[0][2]),
        .O_DataInValid(O_InValid[0][2]), .O_DataInRdy(O_InRdy[0][2]), .O_DataIn(O_In[0][2]),
        .O_DataOut(O_Out[0][2]), .O_DataOutValid(O_OutValid[0][2]), .O_DataOutRdy(O_OutRdy[0][2]));
    
    PE pe1_2(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[1][2]), .W_DataInRdy(W_InRdy[1][2]), .W_DataIn(W_In[1][2]),
        .W_DataOut(W_Out[1][2]), .W_DataOutValid(W_OutValid[1][2]), .W_DataOutRdy(W_OutRdy[1][2]),
        .I_DataInValid(I_InValid[1][2]), .I_DataInRdy(I_InRdy[1][2]), .I_DataIn(I_In[1][2]),
        .I_DataOut(I_Out[1][2]), .I_DataOutValid(I_OutValid[1][2]), .I_DataOutRdy(I_OutRdy[1][2]),
        .O_DataInValid(O_InValid[1][2]), .O_DataInRdy(O_InRdy[1][2]), .O_DataIn(O_In[1][2]),
        .O_DataOut(O_Out[1][2]), .O_DataOutValid(O_OutValid[1][2]), .O_DataOutRdy(O_OutRdy[1][2]));
    
    PE pe2_2(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[2][2]), .W_DataInRdy(W_InRdy[2][2]), .W_DataIn(W_In[2][2]),
        .W_DataOut(W_Out[2][2]), .W_DataOutValid(W_OutValid[2][2]), .W_DataOutRdy(W_OutRdy[2][2]),
        .I_DataInValid(I_InValid[2][2]), .I_DataInRdy(I_InRdy[2][2]), .I_DataIn(I_In[2][2]),
        .I_DataOut(I_Out[2][2]), .I_DataOutValid(I_OutValid[2][2]), .I_DataOutRdy(I_OutRdy[2][2]),
        .O_DataInValid(O_InValid[2][2]), .O_DataInRdy(O_InRdy[2][2]), .O_DataIn(O_In[2][2]),
        .O_DataOut(O_Out[2][2]), .O_DataOutValid(O_OutValid[2][2]), .O_DataOutRdy(O_OutRdy[2][2]));
    PE pe3_2(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[3][2]), .W_DataInRdy(W_InRdy[3][2]), .W_DataIn(W_In[3][2]),
        .W_DataOut(W_Out[3][2]), .W_DataOutValid(W_OutValid[3][2]), .W_DataOutRdy(W_OutRdy[3][2]),
        .I_DataInValid(I_InValid[3][2]), .I_DataInRdy(I_InRdy[3][2]), .I_DataIn(I_In[3][2]),
        .I_DataOut(I_Out[3][2]), .I_DataOutValid(I_OutValid[3][2]), .I_DataOutRdy(I_OutRdy[3][2]),
        .O_DataInValid(O_InValid[3][2]), .O_DataInRdy(O_InRdy[3][2]), .O_DataIn(O_In[3][2]),
        .O_DataOut(O_Out[3][2]), .O_DataOutValid(O_OutValid[3][2]), .O_DataOutRdy(O_OutRdy[3][2]));

    PE pe4_2(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[4][2]), .W_DataInRdy(W_InRdy[4][2]), .W_DataIn(W_In[4][2]),
        .W_DataOut(W_Out[4][2]), .W_DataOutValid(W_OutValid[4][2]), .W_DataOutRdy(W_OutRdy[4][2]),
        .I_DataInValid(I_InValid[4][2]), .I_DataInRdy(I_InRdy[4][2]), .I_DataIn(I_In[4][2]),
        .I_DataOut(I_Out[4][2]), .I_DataOutValid(I_OutValid[4][2]), .I_DataOutRdy(I_OutRdy[4][2]),
        .O_DataInValid(O_InValid[4][2]), .O_DataInRdy(O_InRdy[4][2]), .O_DataIn(O_In[4][2]),
        .O_DataOut(O_Out[4][2]), .O_DataOutValid(O_OutValid[4][2]), .O_DataOutRdy(O_OutRdy[4][2]));

    PE pe5_2(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[5][2]), .W_DataInRdy(W_InRdy[5][2]), .W_DataIn(W_In[5][2]),
        .W_DataOut(W_Out[5][2]), .W_DataOutValid(W_OutValid[5][2]), .W_DataOutRdy(W_OutRdy[5][2]),
        .I_DataInValid(I_InValid[5][2]), .I_DataInRdy(I_InRdy[5][2]), .I_DataIn(I_In[5][2]),
        .I_DataOut(I_Out[5][2]), .I_DataOutValid(I_OutValid[5][2]), .I_DataOutRdy(I_OutRdy[5][2]),
        .O_DataInValid(O_InValid[5][2]), .O_DataInRdy(O_InRdy[5][2]), .O_DataIn(O_In[5][2]),
        .O_DataOut(O_Out[5][2]), .O_DataOutValid(O_OutValid[5][2]), .O_DataOutRdy(O_OutRdy[5][2]));

    PE pe6_2(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[6][2]), .W_DataInRdy(W_InRdy[6][2]), .W_DataIn(W_In[6][2]),
        .W_DataOut(W_Out[6][2]), .W_DataOutValid(W_OutValid[6][2]), .W_DataOutRdy(W_OutRdy[6][2]),
        .I_DataInValid(I_InValid[6][2]), .I_DataInRdy(I_InRdy[6][2]), .I_DataIn(I_In[6][2]),
        .I_DataOut(I_Out[6][2]), .I_DataOutValid(I_OutValid[6][2]), .I_DataOutRdy(I_OutRdy[6][2]),
        .O_DataInValid(O_InValid[6][2]), .O_DataInRdy(O_InRdy[6][2]), .O_DataIn(O_In[6][2]),
        .O_DataOut(O_Out[6][2]), .O_DataOutValid(O_OutValid[6][2]), .O_DataOutRdy(O_OutRdy[6][2]));

    PE pe7_2(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[7][2]), .W_DataInRdy(W_InRdy[7][2]), .W_DataIn(W_In[7][2]),
        .W_DataOut(W_Out[7][2]), .W_DataOutValid(W_OutValid[7][2]), .W_DataOutRdy(W_OutRdy[7][2]),
        .I_DataInValid(I_InValid[7][2]), .I_DataInRdy(I_InRdy[7][2]), .I_DataIn(I_In[7][2]),
        .I_DataOut(I_Out[7][2]), .I_DataOutValid(I_OutValid[7][2]), .I_DataOutRdy(I_OutRdy[7][2]),
        .O_DataInValid(O_InValid[7][2]), .O_DataInRdy(O_InRdy[7][2]), .O_DataIn(O_In[7][2]),
        .O_DataOut(O_Out[7][2]), .O_DataOutValid(O_OutValid[7][2]), .O_DataOutRdy(O_OutRdy[7][2]));

    PE pe8_2(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[8][2]), .W_DataInRdy(W_InRdy[8][2]), .W_DataIn(W_In[8][2]),
        .W_DataOut(W_Out[8][2]), .W_DataOutValid(W_OutValid[8][2]), .W_DataOutRdy(W_OutRdy[8][2]),
        .I_DataInValid(I_InValid[8][2]), .I_DataInRdy(I_InRdy[8][2]), .I_DataIn(I_In[8][2]),
        .I_DataOut(I_Out[8][2]), .I_DataOutValid(I_OutValid[8][2]), .I_DataOutRdy(I_OutRdy[8][2]),
        .O_DataInValid(O_InValid[8][2]), .O_DataInRdy(O_InRdy[8][2]), .O_DataIn(O_In[8][2]),
        .O_DataOut(O_Out[8][2]), .O_DataOutValid(O_OutValid[8][2]), .O_DataOutRdy(O_OutRdy[8][2]));

    //Column 3
    PE pe0_3(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[0][3]), .W_DataInRdy(W_InRdy[0][3]), .W_DataIn(W_In[0][3]),
        .W_DataOut(W_Out[0][3]), .W_DataOutValid(W_OutValid[0][3]), .W_DataOutRdy(W_OutRdy[0][3]),
        .I_DataInValid(I_InValid[0][3]), .I_DataInRdy(I_InRdy[0][3]), .I_DataIn(I_In[0][3]),
        .I_DataOut(I_Out[0][3]), .I_DataOutValid(I_OutValid[0][3]), .I_DataOutRdy(I_OutRdy[0][3]),
        .O_DataInValid(O_InValid[0][3]), .O_DataInRdy(O_InRdy[0][3]), .O_DataIn(O_In[0][3]),
        .O_DataOut(O_Out[0][3]), .O_DataOutValid(O_OutValid[0][3]), .O_DataOutRdy(O_OutRdy[0][3]));
    
    PE pe1_3(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[1][3]), .W_DataInRdy(W_InRdy[1][3]), .W_DataIn(W_In[1][3]),
        .W_DataOut(W_Out[1][3]), .W_DataOutValid(W_OutValid[1][3]), .W_DataOutRdy(W_OutRdy[1][3]),
        .I_DataInValid(I_InValid[1][3]), .I_DataInRdy(I_InRdy[1][3]), .I_DataIn(I_In[1][3]),
        .I_DataOut(I_Out[1][3]), .I_DataOutValid(I_OutValid[1][3]), .I_DataOutRdy(I_OutRdy[1][3]),
        .O_DataInValid(O_InValid[1][3]), .O_DataInRdy(O_InRdy[1][3]), .O_DataIn(O_In[1][3]),
        .O_DataOut(O_Out[1][3]), .O_DataOutValid(O_OutValid[1][3]), .O_DataOutRdy(O_OutRdy[1][3]));
    
    PE pe2_3(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[2][3]), .W_DataInRdy(W_InRdy[2][3]), .W_DataIn(W_In[2][3]),
        .W_DataOut(W_Out[2][3]), .W_DataOutValid(W_OutValid[2][3]), .W_DataOutRdy(W_OutRdy[2][3]),
        .I_DataInValid(I_InValid[2][3]), .I_DataInRdy(I_InRdy[2][3]), .I_DataIn(I_In[2][3]),
        .I_DataOut(I_Out[2][3]), .I_DataOutValid(I_OutValid[2][3]), .I_DataOutRdy(I_OutRdy[2][3]),
        .O_DataInValid(O_InValid[2][3]), .O_DataInRdy(O_InRdy[2][3]), .O_DataIn(O_In[2][3]),
        .O_DataOut(O_Out[2][3]), .O_DataOutValid(O_OutValid[2][3]), .O_DataOutRdy(O_OutRdy[2][3]));

    PE pe3_3(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[3][3]), .W_DataInRdy(W_InRdy[3][3]), .W_DataIn(W_In[3][3]),
        .W_DataOut(W_Out[3][3]), .W_DataOutValid(W_OutValid[3][3]), .W_DataOutRdy(W_OutRdy[3][3]),
        .I_DataInValid(I_InValid[3][3]), .I_DataInRdy(I_InRdy[3][3]), .I_DataIn(I_In[3][3]),
        .I_DataOut(I_Out[3][3]), .I_DataOutValid(I_OutValid[3][3]), .I_DataOutRdy(I_OutRdy[3][3]),
        .O_DataInValid(O_InValid[3][3]), .O_DataInRdy(O_InRdy[3][3]), .O_DataIn(O_In[3][3]),
        .O_DataOut(O_Out[3][3]), .O_DataOutValid(O_OutValid[3][3]), .O_DataOutRdy(O_OutRdy[3][3]));

    PE pe4_3(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[4][3]), .W_DataInRdy(W_InRdy[4][3]), .W_DataIn(W_In[4][3]),
        .W_DataOut(W_Out[4][3]), .W_DataOutValid(W_OutValid[4][3]), .W_DataOutRdy(W_OutRdy[4][3]),
        .I_DataInValid(I_InValid[4][3]), .I_DataInRdy(I_InRdy[4][3]), .I_DataIn(I_In[4][3]),
        .I_DataOut(I_Out[4][3]), .I_DataOutValid(I_OutValid[4][3]), .I_DataOutRdy(I_OutRdy[4][3]),
        .O_DataInValid(O_InValid[4][3]), .O_DataInRdy(O_InRdy[4][3]), .O_DataIn(O_In[4][3]),
        .O_DataOut(O_Out[4][3]), .O_DataOutValid(O_OutValid[4][3]), .O_DataOutRdy(O_OutRdy[4][3]));

    PE pe5_3(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[5][3]), .W_DataInRdy(W_InRdy[5][3]), .W_DataIn(W_In[5][3]),
        .W_DataOut(W_Out[5][3]), .W_DataOutValid(W_OutValid[5][3]), .W_DataOutRdy(W_OutRdy[5][3]),
        .I_DataInValid(I_InValid[5][3]), .I_DataInRdy(I_InRdy[5][3]), .I_DataIn(I_In[5][3]),
        .I_DataOut(I_Out[5][3]), .I_DataOutValid(I_OutValid[5][3]), .I_DataOutRdy(I_OutRdy[5][3]),
        .O_DataInValid(O_InValid[5][3]), .O_DataInRdy(O_InRdy[5][3]), .O_DataIn(O_In[5][3]),
        .O_DataOut(O_Out[5][3]), .O_DataOutValid(O_OutValid[5][3]), .O_DataOutRdy(O_OutRdy[5][3]));

    PE pe6_3(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[6][3]), .W_DataInRdy(W_InRdy[6][3]), .W_DataIn(W_In[6][3]),
        .W_DataOut(W_Out[6][3]), .W_DataOutValid(W_OutValid[6][3]), .W_DataOutRdy(W_OutRdy[6][3]),
        .I_DataInValid(I_InValid[6][3]), .I_DataInRdy(I_InRdy[6][3]), .I_DataIn(I_In[6][3]),
        .I_DataOut(I_Out[6][3]), .I_DataOutValid(I_OutValid[6][3]), .I_DataOutRdy(I_OutRdy[6][3]),
        .O_DataInValid(O_InValid[6][3]), .O_DataInRdy(O_InRdy[6][3]), .O_DataIn(O_In[6][3]),
        .O_DataOut(O_Out[6][3]), .O_DataOutValid(O_OutValid[6][3]), .O_DataOutRdy(O_OutRdy[6][3]));

    PE pe7_3(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[7][3]), .W_DataInRdy(W_InRdy[7][3]), .W_DataIn(W_In[7][3]),
        .W_DataOut(W_Out[7][3]), .W_DataOutValid(W_OutValid[7][3]), .W_DataOutRdy(W_OutRdy[7][3]),
        .I_DataInValid(I_InValid[7][3]), .I_DataInRdy(I_InRdy[7][3]), .I_DataIn(I_In[7][3]),
        .I_DataOut(I_Out[7][3]), .I_DataOutValid(I_OutValid[7][3]), .I_DataOutRdy(I_OutRdy[7][3]),
        .O_DataInValid(O_InValid[7][3]), .O_DataInRdy(O_InRdy[7][3]), .O_DataIn(O_In[7][3]),
        .O_DataOut(O_Out[7][3]), .O_DataOutValid(O_OutValid[7][3]), .O_DataOutRdy(O_OutRdy[7][3]));

    PE pe8_3(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[8][3]), .W_DataInRdy(W_InRdy[8][3]), .W_DataIn(W_In[8][3]),
        .W_DataOut(W_Out[8][3]), .W_DataOutValid(W_OutValid[8][3]), .W_DataOutRdy(W_OutRdy[8][3]),
        .I_DataInValid(I_InValid[8][3]), .I_DataInRdy(I_InRdy[8][3]), .I_DataIn(I_In[8][3]),
        .I_DataOut(I_Out[8][3]), .I_DataOutValid(I_OutValid[8][3]), .I_DataOutRdy(I_OutRdy[8][3]),
        .O_DataInValid(O_InValid[8][3]), .O_DataInRdy(O_InRdy[8][3]), .O_DataIn(O_In[8][3]),
        .O_DataOut(O_Out[8][3]), .O_DataOutValid(O_OutValid[8][3]), .O_DataOutRdy(O_OutRdy[8][3]));

    //ACC

    ACC #(.DataWidth(32),
		.Pipeline_Stages(7),
		.NOPCount(4),
		.NOPCountWidth(4),
        .BufferWidth(2),
        .BufferSize(4))
    acc0 (  .clk(clk), .clk_en(clk_en), .aclr(reset), .sclr(reset), 
            .DataInValid(ACC_DataInValid[0]), .DataIn(ACC_DataIn[0]), 
            .DataOutValid(ACC_DataOutValid[0]), .DataInRdy(ACC_DataInRdy[0]), 
            .DataOutRdy(ACC_DataOutRdy[0]), .DataOut(ACC_DataOut[0]));

    ACC #(.DataWidth(32),
		.Pipeline_Stages(7),
		.NOPCount(4),
		.NOPCountWidth(4),
        .BufferWidth(2),
        .BufferSize(4))
    acc1 (  .clk(clk), .clk_en(clk_en), .aclr(reset), .sclr(reset), 
            .DataInValid(ACC_DataInValid[1]), .DataIn(ACC_DataIn[1]), 
            .DataOutValid(ACC_DataOutValid[1]), .DataInRdy(ACC_DataInRdy[1]), 
            .DataOutRdy(ACC_DataOutRdy[1]), .DataOut(ACC_DataOut[1]));

    ACC #(.DataWidth(32),
		.Pipeline_Stages(7),
		.NOPCount(4),
		.NOPCountWidth(4),
        .BufferWidth(2),
        .BufferSize(4))
    acc2 (  .clk(clk), .clk_en(clk_en), .aclr(reset), .sclr(reset), 
            .DataInValid(ACC_DataInValid[2]), .DataIn(ACC_DataIn[2]), 
            .DataOutValid(ACC_DataOutValid[2]), .DataInRdy(ACC_DataInRdy[2]), 
            .DataOutRdy(ACC_DataOutRdy[2]), .DataOut(ACC_DataOut[2]));

    ACC #(.DataWidth(32),
		.Pipeline_Stages(7),
		.NOPCount(4),
		.NOPCountWidth(4),
        .BufferWidth(2),
        .BufferSize(4))
    acc3 (  .clk(clk), .clk_en(clk_en), .aclr(reset), .sclr(reset), 
            .DataInValid(ACC_DataInValid[3]), .DataIn(ACC_DataIn[3]), 
            .DataOutValid(ACC_DataOutValid[3]), .DataInRdy(ACC_DataInRdy[3]), 
            .DataOutRdy(ACC_DataOutRdy[3]), .DataOut(ACC_DataOut[3]));
    
    assign ACC_DataInValid[0] = O_OutValid[8][0];
    assign ACC_DataInValid[1] = O_OutValid[8][1];
    assign ACC_DataInValid[2] = O_OutValid[8][2];
    assign ACC_DataInValid[3] = O_OutValid[8][3];

    assign ACC_DataIn[0] = O_Out[8][0];
    assign ACC_DataIn[1] = O_Out[8][1];
    assign ACC_DataIn[2] = O_Out[8][2];
    assign ACC_DataIn[3] = O_Out[8][3];

    assign ACC_DataOutRdy[0] = INSTRUCTION[4] && (Output_Read_Address == 0);
    assign ACC_DataOutRdy[1] = INSTRUCTION[4] && (Output_Read_Address == 1);
    assign ACC_DataOutRdy[2] = INSTRUCTION[4] && (Output_Read_Address == 2);
    assign ACC_DataOutRdy[3] = INSTRUCTION[4] && (Output_Read_Address == 3);

    //Kernel
    assign W_InValid[0][0] = INSTRUCTION[1] && (Kernel_Address == 0);
    assign W_InValid[1][0] = INSTRUCTION[1] && (Kernel_Address == 1);
    assign W_InValid[2][0] = INSTRUCTION[1] && (Kernel_Address == 2);
    assign W_InValid[3][0] = INSTRUCTION[1] && (Kernel_Address == 3);
    assign W_InValid[4][0] = INSTRUCTION[1] && (Kernel_Address == 4);
    assign W_InValid[5][0] = INSTRUCTION[1] && (Kernel_Address == 5);
    assign W_InValid[6][0] = INSTRUCTION[1] && (Kernel_Address == 6);
    assign W_InValid[7][0] = INSTRUCTION[1] && (Kernel_Address == 7);
    assign W_InValid[8][0] = INSTRUCTION[1] && (Kernel_Address == 8);

    assign W_InValid[0][1] = W_OutValid[0][0];
    assign W_InValid[1][1] = W_OutValid[1][0];
    assign W_InValid[2][1] = W_OutValid[2][0];
    assign W_InValid[3][1] = W_OutValid[3][0];
    assign W_InValid[4][1] = W_OutValid[4][0];
    assign W_InValid[5][1] = W_OutValid[5][0];
    assign W_InValid[6][1] = W_OutValid[6][0];
    assign W_InValid[7][1] = W_OutValid[7][0];
    assign W_InValid[8][1] = W_OutValid[8][0];

    assign W_InValid[0][2] = W_OutValid[0][1];
    assign W_InValid[1][2] = W_OutValid[1][1];
    assign W_InValid[2][2] = W_OutValid[2][1];
    assign W_InValid[3][2] = W_OutValid[3][1];
    assign W_InValid[4][2] = W_OutValid[4][1];
    assign W_InValid[5][2] = W_OutValid[5][1];
    assign W_InValid[6][2] = W_OutValid[6][1];
    assign W_InValid[7][2] = W_OutValid[7][1];
    assign W_InValid[8][2] = W_OutValid[8][1];

    assign W_InValid[0][3] = W_OutValid[0][2];
    assign W_InValid[1][3] = W_OutValid[1][2];
    assign W_InValid[2][3] = W_OutValid[2][2];
    assign W_InValid[3][3] = W_OutValid[3][2];
    assign W_InValid[4][3] = W_OutValid[4][2];
    assign W_InValid[5][3] = W_OutValid[5][2];
    assign W_InValid[6][3] = W_OutValid[6][2];
    assign W_InValid[7][3] = W_OutValid[7][2];
    assign W_InValid[8][3] = W_OutValid[8][2];

    assign W_In[0][0] = dataa;
    assign W_In[1][0] = dataa;
    assign W_In[2][0] = dataa;
    assign W_In[3][0] = dataa;
    assign W_In[4][0] = dataa;
    assign W_In[5][0] = dataa;
    assign W_In[6][0] = dataa;
    assign W_In[7][0] = dataa;
    assign W_In[8][0] = dataa;

    assign W_In[0][1] = W_Out[0][0];
    assign W_In[1][1] = W_Out[1][0];
    assign W_In[2][1] = W_Out[2][0];
    assign W_In[3][1] = W_Out[3][0];
    assign W_In[4][1] = W_Out[4][0];
    assign W_In[5][1] = W_Out[5][0];
    assign W_In[6][1] = W_Out[6][0];
    assign W_In[7][1] = W_Out[7][0];
    assign W_In[8][1] = W_Out[8][0];

    assign W_In[0][2] = W_Out[0][1];
    assign W_In[1][2] = W_Out[1][1];
    assign W_In[2][2] = W_Out[2][1];
    assign W_In[3][2] = W_Out[3][1];
    assign W_In[4][2] = W_Out[4][1];
    assign W_In[5][2] = W_Out[5][1];
    assign W_In[6][2] = W_Out[6][1];
    assign W_In[7][2] = W_Out[7][1];
    assign W_In[8][2] = W_Out[8][1];

    assign W_In[0][3] = W_Out[0][2];
    assign W_In[1][3] = W_Out[1][2];
    assign W_In[2][3] = W_Out[2][2];
    assign W_In[3][3] = W_Out[3][2];
    assign W_In[4][3] = W_Out[4][2];
    assign W_In[5][3] = W_Out[5][2];
    assign W_In[6][3] = W_Out[6][2];
    assign W_In[7][3] = W_Out[7][2];
    assign W_In[8][3] = W_Out[8][2];

    assign W_OutRdy[0][0] = W_InRdy[0][1];
    assign W_OutRdy[1][0] = W_InRdy[1][1];
    assign W_OutRdy[2][0] = W_InRdy[2][1];
    assign W_OutRdy[3][0] = W_InRdy[3][1];
    assign W_OutRdy[4][0] = W_InRdy[4][1];
    assign W_OutRdy[5][0] = W_InRdy[5][1];
    assign W_OutRdy[6][0] = W_InRdy[6][1];
    assign W_OutRdy[7][0] = W_InRdy[7][1];
    assign W_OutRdy[8][0] = W_InRdy[8][1];

    assign W_OutRdy[0][1] = W_InRdy[0][2];
    assign W_OutRdy[1][1] = W_InRdy[1][2];
    assign W_OutRdy[2][1] = W_InRdy[2][2];
    assign W_OutRdy[3][1] = W_InRdy[3][2];
    assign W_OutRdy[4][1] = W_InRdy[4][2];
    assign W_OutRdy[5][1] = W_InRdy[5][2];
    assign W_OutRdy[6][1] = W_InRdy[6][2];
    assign W_OutRdy[7][1] = W_InRdy[7][2];
    assign W_OutRdy[8][1] = W_InRdy[8][2];

    assign W_OutRdy[0][2] = W_InRdy[0][3];
    assign W_OutRdy[1][2] = W_InRdy[1][3];
    assign W_OutRdy[2][2] = W_InRdy[2][3];
    assign W_OutRdy[3][2] = W_InRdy[3][3];
    assign W_OutRdy[4][2] = W_InRdy[4][3];
    assign W_OutRdy[5][2] = W_InRdy[5][3];
    assign W_OutRdy[6][2] = W_InRdy[6][3];
    assign W_OutRdy[7][2] = W_InRdy[7][3];
    assign W_OutRdy[8][2] = W_InRdy[8][3];

    assign W_OutRdy[0][3] = 1'b1;
    assign W_OutRdy[1][3] = 1'b1;
    assign W_OutRdy[2][3] = 1'b1;
    assign W_OutRdy[3][3] = 1'b1;
    assign W_OutRdy[4][3] = 1'b1;
    assign W_OutRdy[5][3] = 1'b1;
    assign W_OutRdy[6][3] = 1'b1;
    assign W_OutRdy[7][3] = 1'b1;
    assign W_OutRdy[8][3] = 1'b1;

    //Image
    assign I_InValid[0][0] = INSTRUCTION[2] && (Input_Address == 0);
    assign I_InValid[0][1] = INSTRUCTION[2] && (Input_Address == 1);
    assign I_InValid[0][2] = INSTRUCTION[2] && (Input_Address == 2);
    assign I_InValid[0][3] = INSTRUCTION[2] && (Input_Address == 3);
    assign I_InValid[1][3] = INSTRUCTION[2] && (Input_Address == 4);
    assign I_InValid[2][3] = INSTRUCTION[2] && (Input_Address == 5);
    assign I_InValid[3][3] = INSTRUCTION[2] && (Input_Address == 6);
    assign I_InValid[4][3] = INSTRUCTION[2] && (Input_Address == 7);
    assign I_InValid[5][3] = INSTRUCTION[2] && (Input_Address == 8);
    assign I_InValid[6][3] = INSTRUCTION[2] && (Input_Address == 9);
    assign I_InValid[7][3] = INSTRUCTION[2] && (Input_Address == 10);
    assign I_InValid[8][3] = INSTRUCTION[2] && (Input_Address == 11);

    assign I_InValid[1][0] = I_OutValid[0][1];
    assign I_InValid[2][0] = I_OutValid[1][1];
    assign I_InValid[3][0] = I_OutValid[2][1];
    assign I_InValid[4][0] = I_OutValid[3][1];
    assign I_InValid[5][0] = I_OutValid[4][1];
    assign I_InValid[6][0] = I_OutValid[5][1];
    assign I_InValid[7][0] = I_OutValid[6][1];
    assign I_InValid[8][0] = I_OutValid[7][1];

    assign I_InValid[1][1] = I_OutValid[0][2];
    assign I_InValid[2][1] = I_OutValid[1][2];
    assign I_InValid[3][1] = I_OutValid[2][2];
    assign I_InValid[4][1] = I_OutValid[3][2];
    assign I_InValid[5][1] = I_OutValid[4][2];
    assign I_InValid[6][1] = I_OutValid[5][2];
    assign I_InValid[7][1] = I_OutValid[6][2];
    assign I_InValid[8][1] = I_OutValid[7][2];

    assign I_InValid[1][2] = I_OutValid[0][3];
    assign I_InValid[2][2] = I_OutValid[1][3];
    assign I_InValid[3][2] = I_OutValid[2][3];
    assign I_InValid[4][2] = I_OutValid[3][3];
    assign I_InValid[5][2] = I_OutValid[4][3];
    assign I_InValid[6][2] = I_OutValid[5][3];
    assign I_InValid[7][2] = I_OutValid[6][3];
    assign I_InValid[8][2] = I_OutValid[7][3];
    
    assign I_In[0][0] = dataa;
    assign I_In[0][1] = dataa;
    assign I_In[0][2] = dataa;
    assign I_In[0][3] = dataa;
    assign I_In[1][3] = dataa;
    assign I_In[2][3] = dataa;
    assign I_In[3][3] = dataa;
    assign I_In[4][3] = dataa;
    assign I_In[5][3] = dataa;
    assign I_In[6][3] = dataa;
    assign I_In[7][3] = dataa;
    assign I_In[8][3] = dataa;

    assign I_In[1][0] = I_Out[0][1];
    assign I_In[2][0] = I_Out[1][1];
    assign I_In[3][0] = I_Out[2][1];
    assign I_In[4][0] = I_Out[3][1];
    assign I_In[5][0] = I_Out[4][1];
    assign I_In[6][0] = I_Out[5][1];
    assign I_In[7][0] = I_Out[6][1];
    assign I_In[8][0] = I_Out[7][1];

    assign I_In[1][1] = I_Out[0][2];
    assign I_In[2][1] = I_Out[1][2];
    assign I_In[3][1] = I_Out[2][2];
    assign I_In[4][1] = I_Out[3][2];
    assign I_In[5][1] = I_Out[4][2];
    assign I_In[6][1] = I_Out[5][2];
    assign I_In[7][1] = I_Out[6][2];
    assign I_In[8][1] = I_Out[7][2];

    assign I_In[1][2] = I_Out[0][3];
    assign I_In[2][2] = I_Out[1][3];
    assign I_In[3][2] = I_Out[2][3];
    assign I_In[4][2] = I_Out[3][3];
    assign I_In[5][2] = I_Out[4][3];
    assign I_In[6][2] = I_Out[5][3];
    assign I_In[7][2] = I_Out[6][3];
    assign I_In[8][2] = I_Out[7][3];

    assign I_OutRdy[0][0] = 1'b1;
    assign I_OutRdy[0][1] = I_InRdy[1][0];
    assign I_OutRdy[0][2] = I_InRdy[1][1];
    assign I_OutRdy[0][3] = I_InRdy[1][2];

    assign I_OutRdy[1][0] = 1'b1;
    assign I_OutRdy[1][1] = I_InRdy[2][0];
    assign I_OutRdy[1][2] = I_InRdy[2][1];
    assign I_OutRdy[1][3] = I_InRdy[2][2];

    assign I_OutRdy[2][0] = 1'b1;
    assign I_OutRdy[2][1] = I_InRdy[3][0];
    assign I_OutRdy[2][2] = I_InRdy[3][1];
    assign I_OutRdy[2][3] = I_InRdy[3][2];

    assign I_OutRdy[3][0] = 1'b1;
    assign I_OutRdy[3][1] = I_InRdy[4][0];
    assign I_OutRdy[3][2] = I_InRdy[4][1];
    assign I_OutRdy[3][3] = I_InRdy[4][2];

    assign I_OutRdy[4][0] = 1'b1;
    assign I_OutRdy[4][1] = I_InRdy[5][0];
    assign I_OutRdy[4][2] = I_InRdy[5][1];
    assign I_OutRdy[4][3] = I_InRdy[5][2];

    assign I_OutRdy[5][0] = 1'b1;
    assign I_OutRdy[5][1] = I_InRdy[6][0];
    assign I_OutRdy[5][2] = I_InRdy[6][1];
    assign I_OutRdy[5][3] = I_InRdy[6][2];

    assign I_OutRdy[6][0] = 1'b1;
    assign I_OutRdy[6][1] = I_InRdy[7][0];
    assign I_OutRdy[6][2] = I_InRdy[7][1];
    assign I_OutRdy[6][3] = I_InRdy[7][2];

    assign I_OutRdy[7][0] = 1'b1;
    assign I_OutRdy[7][1] = I_InRdy[8][0];
    assign I_OutRdy[7][2] = I_InRdy[8][1];
    assign I_OutRdy[7][3] = I_InRdy[8][2];

    assign I_OutRdy[8][0] = 1'b1;
    assign I_OutRdy[8][1] = 1'b1;
    assign I_OutRdy[8][2] = 1'b1;
    assign I_OutRdy[8][3] = 1'b1;
    
    //Output
    assign O_InValid[0][0] = INSTRUCTION[3] && (Output_Write_Address == 0);
    assign O_InValid[1][0] = O_OutValid[0][0];
    assign O_InValid[2][0] = O_OutValid[1][0];
    assign O_InValid[3][0] = O_OutValid[2][0];
    assign O_InValid[4][0] = O_OutValid[3][0];
    assign O_InValid[5][0] = O_OutValid[4][0];
    assign O_InValid[6][0] = O_OutValid[5][0];
    assign O_InValid[7][0] = O_OutValid[6][0];
    assign O_InValid[8][0] = O_OutValid[7][0];

    assign O_InValid[0][1] = INSTRUCTION[3] && (Output_Write_Address == 1);
    assign O_InValid[1][1] = O_OutValid[0][1];
    assign O_InValid[2][1] = O_OutValid[1][1];
    assign O_InValid[3][1] = O_OutValid[2][1];
    assign O_InValid[4][1] = O_OutValid[3][1];
    assign O_InValid[5][1] = O_OutValid[4][1];
    assign O_InValid[6][1] = O_OutValid[5][1];
    assign O_InValid[7][1] = O_OutValid[6][1];
    assign O_InValid[8][1] = O_OutValid[7][1];

    assign O_InValid[0][2] = INSTRUCTION[3] && (Output_Write_Address == 2);
    assign O_InValid[1][2] = O_OutValid[0][2];
    assign O_InValid[2][2] = O_OutValid[1][2];
    assign O_InValid[3][2] = O_OutValid[2][2];
    assign O_InValid[4][2] = O_OutValid[3][2];
    assign O_InValid[5][2] = O_OutValid[4][2];
    assign O_InValid[6][2] = O_OutValid[5][2];    
    assign O_InValid[7][2] = O_OutValid[6][2];
    assign O_InValid[8][2] = O_OutValid[7][2];

    assign O_InValid[0][3] = INSTRUCTION[3] && (Output_Write_Address == 3);
    assign O_InValid[1][3] = O_OutValid[0][3];
    assign O_InValid[2][3] = O_OutValid[1][3];
    assign O_InValid[3][3] = O_OutValid[2][3];
    assign O_InValid[4][3] = O_OutValid[3][3];
    assign O_InValid[5][3] = O_OutValid[4][3];
    assign O_InValid[6][3] = O_OutValid[5][3];
    assign O_InValid[7][3] = O_OutValid[6][3];
    assign O_InValid[8][3] = O_OutValid[7][3];

    assign O_In[0][0] = dataa;
    assign O_In[1][0] = O_Out[0][0];
    assign O_In[2][0] = O_Out[1][0];
    assign O_In[3][0] = O_Out[2][0];
    assign O_In[4][0] = O_Out[3][0];
    assign O_In[5][0] = O_Out[4][0];
    assign O_In[6][0] = O_Out[5][0];
    assign O_In[7][0] = O_Out[6][0];
    assign O_In[8][0] = O_Out[7][0];

    assign O_In[0][1] = dataa;
    assign O_In[1][1] = O_Out[0][1];
    assign O_In[2][1] = O_Out[1][1];
    assign O_In[3][1] = O_Out[2][1];
    assign O_In[4][1] = O_Out[3][1];
    assign O_In[5][1] = O_Out[4][1];
    assign O_In[6][1] = O_Out[5][1];
    assign O_In[7][1] = O_Out[6][1];
    assign O_In[8][1] = O_Out[7][1];

    assign O_In[0][2] = dataa;
    assign O_In[1][2] = O_Out[0][2];
    assign O_In[2][2] = O_Out[1][2];
    assign O_In[3][2] = O_Out[2][2];
    assign O_In[4][2] = O_Out[3][2];
    assign O_In[5][2] = O_Out[4][2];
    assign O_In[6][2] = O_Out[5][2];
    assign O_In[7][2] = O_Out[6][2];
    assign O_In[8][2] = O_Out[7][2];

    assign O_In[0][3] = dataa;
    assign O_In[1][3] = O_Out[0][3];
    assign O_In[2][3] = O_Out[1][3];
    assign O_In[3][3] = O_Out[2][3];
    assign O_In[4][3] = O_Out[3][3];
    assign O_In[5][3] = O_Out[4][3];
    assign O_In[6][3] = O_Out[5][3];
    assign O_In[7][3] = O_Out[6][3];
    assign O_In[8][3] = O_Out[7][3];

    assign O_OutRdy[0][0] = O_InRdy[1][0];
    assign O_OutRdy[1][0] = O_InRdy[2][0];
    assign O_OutRdy[2][0] = O_InRdy[3][0];
    assign O_OutRdy[3][0] = O_InRdy[4][0];
    assign O_OutRdy[4][0] = O_InRdy[5][0];
    assign O_OutRdy[5][0] = O_InRdy[6][0];
    assign O_OutRdy[6][0] = O_InRdy[7][0];
    assign O_OutRdy[7][0] = O_InRdy[8][0];
    assign O_OutRdy[8][0] = ACC_DataInRdy[0];

    assign O_OutRdy[0][1] = O_InRdy[1][1];
    assign O_OutRdy[1][1] = O_InRdy[2][1];
    assign O_OutRdy[2][1] = O_InRdy[3][1];
    assign O_OutRdy[3][1] = O_InRdy[4][1];
    assign O_OutRdy[4][1] = O_InRdy[5][1];
    assign O_OutRdy[5][1] = O_InRdy[6][1];
    assign O_OutRdy[6][1] = O_InRdy[7][1];
    assign O_OutRdy[7][1] = O_InRdy[8][1];
    assign O_OutRdy[8][1] = ACC_DataInRdy[1];

    assign O_OutRdy[0][2] = O_InRdy[1][2];
    assign O_OutRdy[1][2] = O_InRdy[2][2];
    assign O_OutRdy[2][2] = O_InRdy[3][2];
    assign O_OutRdy[3][2] = O_InRdy[4][2];
    assign O_OutRdy[4][2] = O_InRdy[5][2];
    assign O_OutRdy[5][2] = O_InRdy[6][2];
    assign O_OutRdy[6][2] = O_InRdy[7][2];
    assign O_OutRdy[7][2] = O_InRdy[8][2];
    assign O_OutRdy[8][2] = ACC_DataInRdy[2];

    assign O_OutRdy[0][3] = O_InRdy[1][3];
    assign O_OutRdy[1][3] = O_InRdy[2][3];
    assign O_OutRdy[2][3] = O_InRdy[3][3];
    assign O_OutRdy[3][3] = O_InRdy[4][3];
    assign O_OutRdy[4][3] = O_InRdy[5][3];
    assign O_OutRdy[5][3] = O_InRdy[6][3];
    assign O_OutRdy[6][3] = O_InRdy[7][3];
    assign O_OutRdy[7][3] = O_InRdy[8][3];
    assign O_OutRdy[8][3] = ACC_DataInRdy[3];

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
            done = ACC_DataOutValid[Output_Read_Address];
            result = ACC_DataOut[Output_Read_Address];
        end
        else begin
            done = 1'b0;
            result = 32'b0;
        end
    end


endmodule
