module PE_37_Instruction
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
    reg [3:0] Input_Address;
    reg [2:0] Output_Write_Address;
    reg [2:0] Output_Read_Address;

    parameter PE_SIZE_X = 7;
    parameter PE_SIZE_Y = 3;

    wire [4:0] INSTRUCTION;

    assign INSTRUCTION[0] = start && (n == 0); //reset
    assign INSTRUCTION[1] = start && (n == 1); //send weight
    assign INSTRUCTION[2] = start && (n == 2); //send input
    assign INSTRUCTION[3] = start && (n == 3); //send output
    assign INSTRUCTION[4] = (n == 4); //get result

    //ACC Connect Signals
    wire [PE_SIZE_X - 1:0] ACC_DataInValid;
    wire [DataWidth - 1:0] ACC_DataIn [0:PE_SIZE_X - 1];
    wire [PE_SIZE_X - 1:0] ACC_DataOutValid;
    wire [PE_SIZE_X - 1:0] ACC_DataInRdy;
    wire [PE_SIZE_X - 1:0] ACC_DataOutRdy;
    wire [DataWidth - 1:0] ACC_DataOut [0:PE_SIZE_X - 1];

    //Address Counter
    always @ (posedge clk) begin
        if(reset && clk_en) begin
            Kernel_Address <= 0;
        end
        else if(INSTRUCTION[1] && (Kernel_Address == (PE_SIZE_Y - 1)) && clk_en) begin
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
        else if(INSTRUCTION[2] && (Input_Address == (PE_SIZE_X + PE_SIZE_Y - 1 - 1)) && clk_en) begin
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
        else if(INSTRUCTION[3] && (Output_Write_Address == (PE_SIZE_X - 1)) && clk_en) begin
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
        else if(INSTRUCTION[4] && ACC_DataOutValid[Output_Read_Address] && (Output_Read_Address == (PE_SIZE_X - 1))&& clk_en) begin
            Output_Read_Address <= 0;
        end
        else if(INSTRUCTION[4] && ACC_DataOutValid[Output_Read_Address] && clk_en) begin
            Output_Read_Address <= Output_Read_Address + 1;
        end
        else begin
            Output_Read_Address <= Output_Read_Address;
        end

    end

    //PE Connect Signals
    wire W_InValid [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];
    wire I_InValid [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];
    wire O_InValid [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];

    wire W_InRdy [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];
    wire I_InRdy [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];
    wire O_InRdy [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];

    wire [DataWidth - 1:0] W_In [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];
    wire [DataWidth - 1:0] I_In [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];
    wire [DataWidth - 1:0] O_In [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];

    wire [DataWidth - 1:0] W_Out [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];
    wire [DataWidth - 1:0] I_Out [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];
    wire [DataWidth - 1:0] O_Out [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];

    wire W_OutValid [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];
    wire I_OutValid [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];
    wire O_OutValid [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];

    wire W_OutRdy [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];
    wire I_OutRdy [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];
    wire O_OutRdy [0:PE_SIZE_Y - 1][0:PE_SIZE_X - 1];

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

    //Column 4
    PE pe0_4(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[0][4]), .W_DataInRdy(W_InRdy[0][4]), .W_DataIn(W_In[0][4]),
        .W_DataOut(W_Out[0][4]), .W_DataOutValid(W_OutValid[0][4]), .W_DataOutRdy(W_OutRdy[0][4]),
        .I_DataInValid(I_InValid[0][4]), .I_DataInRdy(I_InRdy[0][4]), .I_DataIn(I_In[0][4]),
        .I_DataOut(I_Out[0][4]), .I_DataOutValid(I_OutValid[0][4]), .I_DataOutRdy(I_OutRdy[0][4]),
        .O_DataInValid(O_InValid[0][4]), .O_DataInRdy(O_InRdy[0][4]), .O_DataIn(O_In[0][4]),
        .O_DataOut(O_Out[0][4]), .O_DataOutValid(O_OutValid[0][4]), .O_DataOutRdy(O_OutRdy[0][4]));
    
    PE pe1_4(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[1][4]), .W_DataInRdy(W_InRdy[1][4]), .W_DataIn(W_In[1][4]),
        .W_DataOut(W_Out[1][4]), .W_DataOutValid(W_OutValid[1][4]), .W_DataOutRdy(W_OutRdy[1][4]),
        .I_DataInValid(I_InValid[1][4]), .I_DataInRdy(I_InRdy[1][4]), .I_DataIn(I_In[1][4]),
        .I_DataOut(I_Out[1][4]), .I_DataOutValid(I_OutValid[1][4]), .I_DataOutRdy(I_OutRdy[1][4]),
        .O_DataInValid(O_InValid[1][4]), .O_DataInRdy(O_InRdy[1][4]), .O_DataIn(O_In[1][4]),
        .O_DataOut(O_Out[1][4]), .O_DataOutValid(O_OutValid[1][4]), .O_DataOutRdy(O_OutRdy[1][4]));
    
    PE pe2_4(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[2][4]), .W_DataInRdy(W_InRdy[2][4]), .W_DataIn(W_In[2][4]),
        .W_DataOut(W_Out[2][4]), .W_DataOutValid(W_OutValid[2][4]), .W_DataOutRdy(W_OutRdy[2][4]),
        .I_DataInValid(I_InValid[2][4]), .I_DataInRdy(I_InRdy[2][4]), .I_DataIn(I_In[2][4]),
        .I_DataOut(I_Out[2][4]), .I_DataOutValid(I_OutValid[2][4]), .I_DataOutRdy(I_OutRdy[2][4]),
        .O_DataInValid(O_InValid[2][4]), .O_DataInRdy(O_InRdy[2][4]), .O_DataIn(O_In[2][4]),
        .O_DataOut(O_Out[2][4]), .O_DataOutValid(O_OutValid[2][4]), .O_DataOutRdy(O_OutRdy[2][4]));

    //Column 5
    PE pe0_5(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[0][5]), .W_DataInRdy(W_InRdy[0][5]), .W_DataIn(W_In[0][5]),
        .W_DataOut(W_Out[0][5]), .W_DataOutValid(W_OutValid[0][5]), .W_DataOutRdy(W_OutRdy[0][5]),
        .I_DataInValid(I_InValid[0][5]), .I_DataInRdy(I_InRdy[0][5]), .I_DataIn(I_In[0][5]),
        .I_DataOut(I_Out[0][5]), .I_DataOutValid(I_OutValid[0][5]), .I_DataOutRdy(I_OutRdy[0][5]),
        .O_DataInValid(O_InValid[0][5]), .O_DataInRdy(O_InRdy[0][5]), .O_DataIn(O_In[0][5]),
        .O_DataOut(O_Out[0][5]), .O_DataOutValid(O_OutValid[0][5]), .O_DataOutRdy(O_OutRdy[0][5]));
    
    PE pe1_5(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[1][5]), .W_DataInRdy(W_InRdy[1][5]), .W_DataIn(W_In[1][5]),
        .W_DataOut(W_Out[1][5]), .W_DataOutValid(W_OutValid[1][5]), .W_DataOutRdy(W_OutRdy[1][5]),
        .I_DataInValid(I_InValid[1][5]), .I_DataInRdy(I_InRdy[1][5]), .I_DataIn(I_In[1][5]),
        .I_DataOut(I_Out[1][5]), .I_DataOutValid(I_OutValid[1][5]), .I_DataOutRdy(I_OutRdy[1][5]),
        .O_DataInValid(O_InValid[1][5]), .O_DataInRdy(O_InRdy[1][5]), .O_DataIn(O_In[1][5]),
        .O_DataOut(O_Out[1][5]), .O_DataOutValid(O_OutValid[1][5]), .O_DataOutRdy(O_OutRdy[1][5]));
    
    PE pe2_5(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[2][5]), .W_DataInRdy(W_InRdy[2][5]), .W_DataIn(W_In[2][5]),
        .W_DataOut(W_Out[2][5]), .W_DataOutValid(W_OutValid[2][5]), .W_DataOutRdy(W_OutRdy[2][5]),
        .I_DataInValid(I_InValid[2][5]), .I_DataInRdy(I_InRdy[2][5]), .I_DataIn(I_In[2][5]),
        .I_DataOut(I_Out[2][5]), .I_DataOutValid(I_OutValid[2][5]), .I_DataOutRdy(I_OutRdy[2][5]),
        .O_DataInValid(O_InValid[2][5]), .O_DataInRdy(O_InRdy[2][5]), .O_DataIn(O_In[2][5]),
        .O_DataOut(O_Out[2][5]), .O_DataOutValid(O_OutValid[2][5]), .O_DataOutRdy(O_OutRdy[2][5]));

    //Column 6
    PE pe0_6(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[0][6]), .W_DataInRdy(W_InRdy[0][6]), .W_DataIn(W_In[0][6]),
        .W_DataOut(W_Out[0][6]), .W_DataOutValid(W_OutValid[0][6]), .W_DataOutRdy(W_OutRdy[0][6]),
        .I_DataInValid(I_InValid[0][6]), .I_DataInRdy(I_InRdy[0][6]), .I_DataIn(I_In[0][6]),
        .I_DataOut(I_Out[0][6]), .I_DataOutValid(I_OutValid[0][6]), .I_DataOutRdy(I_OutRdy[0][6]),
        .O_DataInValid(O_InValid[0][6]), .O_DataInRdy(O_InRdy[0][6]), .O_DataIn(O_In[0][6]),
        .O_DataOut(O_Out[0][6]), .O_DataOutValid(O_OutValid[0][6]), .O_DataOutRdy(O_OutRdy[0][6]));
    
    PE pe1_6(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[1][6]), .W_DataInRdy(W_InRdy[1][6]), .W_DataIn(W_In[1][6]),
        .W_DataOut(W_Out[1][6]), .W_DataOutValid(W_OutValid[1][6]), .W_DataOutRdy(W_OutRdy[1][6]),
        .I_DataInValid(I_InValid[1][6]), .I_DataInRdy(I_InRdy[1][6]), .I_DataIn(I_In[1][6]),
        .I_DataOut(I_Out[1][6]), .I_DataOutValid(I_OutValid[1][6]), .I_DataOutRdy(I_OutRdy[1][6]),
        .O_DataInValid(O_InValid[1][6]), .O_DataInRdy(O_InRdy[1][6]), .O_DataIn(O_In[1][6]),
        .O_DataOut(O_Out[1][6]), .O_DataOutValid(O_OutValid[1][6]), .O_DataOutRdy(O_OutRdy[1][6]));
    
    PE pe2_6(   
        .clk(clk), .clk_en(clk_en), .aclr(reset),
        .W_DataInValid(W_InValid[2][6]), .W_DataInRdy(W_InRdy[2][6]), .W_DataIn(W_In[2][6]),
        .W_DataOut(W_Out[2][6]), .W_DataOutValid(W_OutValid[2][6]), .W_DataOutRdy(W_OutRdy[2][6]),
        .I_DataInValid(I_InValid[2][6]), .I_DataInRdy(I_InRdy[2][6]), .I_DataIn(I_In[2][6]),
        .I_DataOut(I_Out[2][6]), .I_DataOutValid(I_OutValid[2][6]), .I_DataOutRdy(I_OutRdy[2][6]),
        .O_DataInValid(O_InValid[2][6]), .O_DataInRdy(O_InRdy[2][6]), .O_DataIn(O_In[2][6]),
        .O_DataOut(O_Out[2][6]), .O_DataOutValid(O_OutValid[2][6]), .O_DataOutRdy(O_OutRdy[2][6]));




    //ACC

    ACC #(.DataWidth(32),
		.Pipeline_Stages(7),
		.NOPCount(9),
		.NOPCountWidth(4),
        .BufferWidth(2),
        .BufferSize(4))
    acc0 (  .clk(clk), .clk_en(clk_en), .aclr(reset), .sclr(reset), 
            .DataInValid(ACC_DataInValid[0]), .DataIn(ACC_DataIn[0]), 
            .DataOutValid(ACC_DataOutValid[0]), .DataInRdy(ACC_DataInRdy[0]), 
            .DataOutRdy(ACC_DataOutRdy[0]), .DataOut(ACC_DataOut[0]));

    ACC #(.DataWidth(32),
		.Pipeline_Stages(7),
		.NOPCount(9),
		.NOPCountWidth(4),
        .BufferWidth(2),
        .BufferSize(4))
    acc1 (  .clk(clk), .clk_en(clk_en), .aclr(reset), .sclr(reset), 
            .DataInValid(ACC_DataInValid[1]), .DataIn(ACC_DataIn[1]), 
            .DataOutValid(ACC_DataOutValid[1]), .DataInRdy(ACC_DataInRdy[1]), 
            .DataOutRdy(ACC_DataOutRdy[1]), .DataOut(ACC_DataOut[1]));

    ACC #(.DataWidth(32),
		.Pipeline_Stages(7),
		.NOPCount(9),
		.NOPCountWidth(4),
        .BufferWidth(2),
        .BufferSize(4))
    acc2 (  .clk(clk), .clk_en(clk_en), .aclr(reset), .sclr(reset), 
            .DataInValid(ACC_DataInValid[2]), .DataIn(ACC_DataIn[2]), 
            .DataOutValid(ACC_DataOutValid[2]), .DataInRdy(ACC_DataInRdy[2]), 
            .DataOutRdy(ACC_DataOutRdy[2]), .DataOut(ACC_DataOut[2]));

    ACC #(.DataWidth(32),
		.Pipeline_Stages(7),
		.NOPCount(9),
		.NOPCountWidth(4),
        .BufferWidth(2),
        .BufferSize(4))
    acc3 (  .clk(clk), .clk_en(clk_en), .aclr(reset), .sclr(reset), 
            .DataInValid(ACC_DataInValid[3]), .DataIn(ACC_DataIn[3]), 
            .DataOutValid(ACC_DataOutValid[3]), .DataInRdy(ACC_DataInRdy[3]), 
            .DataOutRdy(ACC_DataOutRdy[3]), .DataOut(ACC_DataOut[3]));

    ACC #(.DataWidth(32),
		.Pipeline_Stages(7),
		.NOPCount(9),
		.NOPCountWidth(4),
        .BufferWidth(2),
        .BufferSize(4))
    acc4 (  .clk(clk), .clk_en(clk_en), .aclr(reset), .sclr(reset), 
            .DataInValid(ACC_DataInValid[4]), .DataIn(ACC_DataIn[4]), 
            .DataOutValid(ACC_DataOutValid[4]), .DataInRdy(ACC_DataInRdy[4]), 
            .DataOutRdy(ACC_DataOutRdy[4]), .DataOut(ACC_DataOut[4]));

    ACC #(.DataWidth(32),
		.Pipeline_Stages(7),
		.NOPCount(9),
		.NOPCountWidth(4),
        .BufferWidth(2),
        .BufferSize(4))
    acc5 (  .clk(clk), .clk_en(clk_en), .aclr(reset), .sclr(reset), 
            .DataInValid(ACC_DataInValid[5]), .DataIn(ACC_DataIn[5]), 
            .DataOutValid(ACC_DataOutValid[5]), .DataInRdy(ACC_DataInRdy[5]), 
            .DataOutRdy(ACC_DataOutRdy[5]), .DataOut(ACC_DataOut[5]));

    ACC #(.DataWidth(32),
		.Pipeline_Stages(7),
		.NOPCount(9),
		.NOPCountWidth(4),
        .BufferWidth(2),
        .BufferSize(4))
    acc6 (  .clk(clk), .clk_en(clk_en), .aclr(reset), .sclr(reset), 
            .DataInValid(ACC_DataInValid[6]), .DataIn(ACC_DataIn[6]), 
            .DataOutValid(ACC_DataOutValid[6]), .DataInRdy(ACC_DataInRdy[6]), 
            .DataOutRdy(ACC_DataOutRdy[6]), .DataOut(ACC_DataOut[6]));
    
    assign ACC_DataInValid[0] = O_OutValid[2][0];
    assign ACC_DataInValid[1] = O_OutValid[2][1];
    assign ACC_DataInValid[2] = O_OutValid[2][2];
    assign ACC_DataInValid[3] = O_OutValid[2][3];
    assign ACC_DataInValid[4] = O_OutValid[2][4];
    assign ACC_DataInValid[5] = O_OutValid[2][5];
    assign ACC_DataInValid[6] = O_OutValid[2][6];    

    assign ACC_DataIn[0] = O_Out[2][0];
    assign ACC_DataIn[1] = O_Out[2][1];
    assign ACC_DataIn[2] = O_Out[2][2];
    assign ACC_DataIn[3] = O_Out[2][3];
    assign ACC_DataIn[4] = O_Out[2][4];
    assign ACC_DataIn[5] = O_Out[2][5];
    assign ACC_DataIn[6] = O_Out[2][6];

    assign ACC_DataOutRdy[0] = INSTRUCTION[4] && (Output_Read_Address == 0);
    assign ACC_DataOutRdy[1] = INSTRUCTION[4] && (Output_Read_Address == 1);
    assign ACC_DataOutRdy[2] = INSTRUCTION[4] && (Output_Read_Address == 2);
    assign ACC_DataOutRdy[3] = INSTRUCTION[4] && (Output_Read_Address == 3);
    assign ACC_DataOutRdy[4] = INSTRUCTION[4] && (Output_Read_Address == 4);
    assign ACC_DataOutRdy[5] = INSTRUCTION[4] && (Output_Read_Address == 5);
    assign ACC_DataOutRdy[6] = INSTRUCTION[4] && (Output_Read_Address == 6);

    //Kernel
    assign W_InValid[0][0] = INSTRUCTION[1] && (Kernel_Address == 0);
    assign W_InValid[1][0] = INSTRUCTION[1] && (Kernel_Address == 1);
    assign W_InValid[2][0] = INSTRUCTION[1] && (Kernel_Address == 2);

    assign W_InValid[0][1] = W_OutValid[0][0];
    assign W_InValid[1][1] = W_OutValid[1][0];
    assign W_InValid[2][1] = W_OutValid[2][0];

    assign W_InValid[0][2] = W_OutValid[0][1];
    assign W_InValid[1][2] = W_OutValid[1][1];
    assign W_InValid[2][2] = W_OutValid[2][1];

    assign W_InValid[0][3] = W_OutValid[0][2];
    assign W_InValid[1][3] = W_OutValid[1][2];
    assign W_InValid[2][3] = W_OutValid[2][2];

    assign W_InValid[0][4] = W_OutValid[0][3];
    assign W_InValid[1][4] = W_OutValid[1][3];
    assign W_InValid[2][4] = W_OutValid[2][3];

    assign W_InValid[0][5] = W_OutValid[0][4];
    assign W_InValid[1][5] = W_OutValid[1][4];
    assign W_InValid[2][5] = W_OutValid[2][4];

    assign W_InValid[0][6] = W_OutValid[0][5];
    assign W_InValid[1][6] = W_OutValid[1][5];
    assign W_InValid[2][6] = W_OutValid[2][5];

    assign W_In[0][0] = dataa;
    assign W_In[1][0] = dataa;
    assign W_In[2][0] = dataa;

    assign W_In[0][1] = W_Out[0][0];
    assign W_In[1][1] = W_Out[1][0];
    assign W_In[2][1] = W_Out[2][0];

    assign W_In[0][2] = W_Out[0][1];
    assign W_In[1][2] = W_Out[1][1];
    assign W_In[2][2] = W_Out[2][1];

    assign W_In[0][3] = W_Out[0][2];
    assign W_In[1][3] = W_Out[1][2];
    assign W_In[2][3] = W_Out[2][2];

    assign W_In[0][4] = W_Out[0][3];
    assign W_In[1][4] = W_Out[1][3];
    assign W_In[2][4] = W_Out[2][3];

    assign W_In[0][5] = W_Out[0][4];
    assign W_In[1][5] = W_Out[1][4];
    assign W_In[2][5] = W_Out[2][4];

    assign W_In[0][6] = W_Out[0][5];
    assign W_In[1][6] = W_Out[1][5];
    assign W_In[2][6] = W_Out[2][5];

    assign W_OutRdy[0][0] = W_InRdy[0][1];
    assign W_OutRdy[1][0] = W_InRdy[1][1];
    assign W_OutRdy[2][0] = W_InRdy[2][1];

    assign W_OutRdy[0][1] = W_InRdy[0][2];
    assign W_OutRdy[1][1] = W_InRdy[1][2];
    assign W_OutRdy[2][1] = W_InRdy[2][2];

    assign W_OutRdy[0][2] = W_InRdy[0][3];
    assign W_OutRdy[1][2] = W_InRdy[1][3];
    assign W_OutRdy[2][2] = W_InRdy[2][3];

    assign W_OutRdy[0][3] = W_InRdy[0][4];
    assign W_OutRdy[1][3] = W_InRdy[1][4];
    assign W_OutRdy[2][3] = W_InRdy[2][4];

    assign W_OutRdy[0][4] = W_InRdy[0][5];
    assign W_OutRdy[1][4] = W_InRdy[1][5];
    assign W_OutRdy[2][4] = W_InRdy[2][5];

    assign W_OutRdy[0][5] = W_InRdy[0][6];
    assign W_OutRdy[1][5] = W_InRdy[1][6];
    assign W_OutRdy[2][5] = W_InRdy[2][6];

    assign W_OutRdy[0][6] = 1'b1;
    assign W_OutRdy[1][6] = 1'b1;
    assign W_OutRdy[2][6] = 1'b1;

    //Image
    assign I_InValid[0][0] = INSTRUCTION[2] && (Input_Address == 0);
    assign I_InValid[0][1] = INSTRUCTION[2] && (Input_Address == 1);
    assign I_InValid[0][2] = INSTRUCTION[2] && (Input_Address == 2);
    assign I_InValid[0][3] = INSTRUCTION[2] && (Input_Address == 3);
    assign I_InValid[0][4] = INSTRUCTION[2] && (Input_Address == 4);
    assign I_InValid[0][5] = INSTRUCTION[2] && (Input_Address == 5);
    assign I_InValid[0][6] = INSTRUCTION[2] && (Input_Address == 6);
    assign I_InValid[1][6] = INSTRUCTION[2] && (Input_Address == 7);
    assign I_InValid[2][6] = INSTRUCTION[2] && (Input_Address == 8);

    assign I_InValid[1][0] = I_OutValid[0][1];
    assign I_InValid[2][0] = I_OutValid[1][1];

    assign I_InValid[1][1] = I_OutValid[0][2];
    assign I_InValid[2][1] = I_OutValid[1][2];

    assign I_InValid[1][2] = I_OutValid[0][3];
    assign I_InValid[2][2] = I_OutValid[1][3];

    assign I_InValid[1][3] = I_OutValid[0][4];
    assign I_InValid[2][3] = I_OutValid[1][4];

    assign I_InValid[1][4] = I_OutValid[0][5];
    assign I_InValid[2][4] = I_OutValid[1][5];

    assign I_InValid[1][5] = I_OutValid[0][6];
    assign I_InValid[2][5] = I_OutValid[1][6];
    
    assign I_In[0][0] = dataa;
    assign I_In[0][1] = dataa;
    assign I_In[0][2] = dataa;
    assign I_In[0][3] = dataa;
    assign I_In[0][4] = dataa;
    assign I_In[0][5] = dataa;
    assign I_In[0][6] = dataa;
    assign I_In[1][6] = dataa;
    assign I_In[2][6] = dataa;

    assign I_In[1][0] = I_Out[0][1];
    assign I_In[2][0] = I_Out[1][1];

    assign I_In[1][1] = I_Out[0][2];
    assign I_In[2][1] = I_Out[1][2];

    assign I_In[1][2] = I_Out[0][3];
    assign I_In[2][2] = I_Out[1][3];

    assign I_In[1][3] = I_Out[0][4];
    assign I_In[2][3] = I_Out[1][4];

    assign I_In[1][4] = I_Out[0][5];
    assign I_In[2][4] = I_Out[1][5];

    assign I_In[1][5] = I_Out[0][6];
    assign I_In[2][5] = I_Out[1][6];

    assign I_OutRdy[0][0] = 1'b1;
    assign I_OutRdy[0][1] = I_InRdy[1][0];
    assign I_OutRdy[0][2] = I_InRdy[1][1];
    assign I_OutRdy[0][3] = I_InRdy[1][2];
    assign I_OutRdy[0][4] = I_InRdy[1][3];
    assign I_OutRdy[0][5] = I_InRdy[1][4];
    assign I_OutRdy[0][6] = I_InRdy[1][5];

    assign I_OutRdy[1][0] = 1'b1;
    assign I_OutRdy[1][1] = I_InRdy[2][0];
    assign I_OutRdy[1][2] = I_InRdy[2][1];
    assign I_OutRdy[1][3] = I_InRdy[2][2];
    assign I_OutRdy[1][4] = I_InRdy[2][3];
    assign I_OutRdy[1][5] = I_InRdy[2][4];
    assign I_OutRdy[1][6] = I_InRdy[2][5];

    assign I_OutRdy[2][0] = 1'b1;
    assign I_OutRdy[2][1] = 1'b1;
    assign I_OutRdy[2][2] = 1'b1;
    assign I_OutRdy[2][3] = 1'b1;
    assign I_OutRdy[2][4] = 1'b1;
    assign I_OutRdy[2][5] = 1'b1;
    assign I_OutRdy[2][6] = 1'b1;
    
    //Output
    assign O_InValid[0][0] = INSTRUCTION[3] && (Output_Write_Address == 0);
    assign O_InValid[1][0] = O_OutValid[0][0];
    assign O_InValid[2][0] = O_OutValid[1][0];

    assign O_InValid[0][1] = INSTRUCTION[3] && (Output_Write_Address == 1);
    assign O_InValid[1][1] = O_OutValid[0][1];
    assign O_InValid[2][1] = O_OutValid[1][1];

    assign O_InValid[0][2] = INSTRUCTION[3] && (Output_Write_Address == 2);
    assign O_InValid[1][2] = O_OutValid[0][2];
    assign O_InValid[2][2] = O_OutValid[1][2];

    assign O_InValid[0][3] = INSTRUCTION[3] && (Output_Write_Address == 3);
    assign O_InValid[1][3] = O_OutValid[0][3];
    assign O_InValid[2][3] = O_OutValid[1][3];

    assign O_InValid[0][4] = INSTRUCTION[3] && (Output_Write_Address == 4);
    assign O_InValid[1][4] = O_OutValid[0][4];
    assign O_InValid[2][4] = O_OutValid[1][4];

    assign O_InValid[0][5] = INSTRUCTION[3] && (Output_Write_Address == 5);
    assign O_InValid[1][5] = O_OutValid[0][5];
    assign O_InValid[2][5] = O_OutValid[1][5];

    assign O_InValid[0][6] = INSTRUCTION[3] && (Output_Write_Address == 6);
    assign O_InValid[1][6] = O_OutValid[0][6];
    assign O_InValid[2][6] = O_OutValid[1][6];

    assign O_In[0][0] = dataa;
    assign O_In[1][0] = O_Out[0][0];
    assign O_In[2][0] = O_Out[1][0];

    assign O_In[0][1] = dataa;
    assign O_In[1][1] = O_Out[0][1];
    assign O_In[2][1] = O_Out[1][1];

    assign O_In[0][2] = dataa;
    assign O_In[1][2] = O_Out[0][2];
    assign O_In[2][2] = O_Out[1][2];

    assign O_In[0][3] = dataa;
    assign O_In[1][3] = O_Out[0][3];
    assign O_In[2][3] = O_Out[1][3];

    assign O_In[0][4] = dataa;
    assign O_In[1][4] = O_Out[0][4];
    assign O_In[2][4] = O_Out[1][4];

    assign O_In[0][5] = dataa;
    assign O_In[1][5] = O_Out[0][5];
    assign O_In[2][5] = O_Out[1][5];

    assign O_In[0][6] = dataa;
    assign O_In[1][6] = O_Out[0][6];
    assign O_In[2][6] = O_Out[1][6];

    assign O_OutRdy[0][0] = O_InRdy[1][0];
    assign O_OutRdy[1][0] = O_InRdy[2][0];
    assign O_OutRdy[2][0] = ACC_DataInRdy[0];

    assign O_OutRdy[0][1] = O_InRdy[1][1];
    assign O_OutRdy[1][1] = O_InRdy[2][1];
    assign O_OutRdy[2][1] = ACC_DataInRdy[1];

    assign O_OutRdy[0][2] = O_InRdy[1][2];
    assign O_OutRdy[1][2] = O_InRdy[2][2];
    assign O_OutRdy[2][2] = ACC_DataInRdy[2];

    assign O_OutRdy[0][3] = O_InRdy[1][3];
    assign O_OutRdy[1][3] = O_InRdy[2][3];
    assign O_OutRdy[2][3] = ACC_DataInRdy[3];

    assign O_OutRdy[0][4] = O_InRdy[1][4];
    assign O_OutRdy[1][4] = O_InRdy[2][4];
    assign O_OutRdy[2][4] = ACC_DataInRdy[4];

    assign O_OutRdy[0][5] = O_InRdy[1][5];
    assign O_OutRdy[1][5] = O_InRdy[2][5];
    assign O_OutRdy[2][5] = ACC_DataInRdy[5];

    assign O_OutRdy[0][6] = O_InRdy[1][6];
    assign O_OutRdy[1][6] = O_InRdy[2][6];
    assign O_OutRdy[2][6] = ACC_DataInRdy[6];

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
