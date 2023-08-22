
module Top(
		input  wire        pll_ref_clk,                                           //                         clk.clk
		output wire [7:0]  led_pio,                // led_pio_external_connection.export
		output wire [12:0] mem_a,                                      //                      memory.mem_a
		output wire [2:0]  mem_ba,                                     //                            .mem_ba
		output wire [0:0]  mem_ck,                                     //                            .mem_ck
		output wire [0:0]  mem_ck_n,                                   //                            .mem_ck_n
		output wire [0:0]  mem_cke,                                    //                            .mem_cke
		output wire [0:0]  mem_cs_n,                                   //                            .mem_cs_n
		output wire [0:0]  mem_dm,                                     //                            .mem_dm
		output wire [0:0]  mem_ras_n,                                  //                            .mem_ras_n
		output wire [0:0]  mem_cas_n,                                  //                            .mem_cas_n
		output wire [0:0]  mem_we_n,                                   //                            .mem_we_n
		output wire        mem_reset_n,                                //                            .mem_reset_n
		inout  wire [7:0]  mem_dq,                                     //                            .mem_dq
		inout  wire [0:0]  mem_dqs,                                    //                            .mem_dqs
		inout  wire [0:0]  mem_dqs_n,                                  //                            .mem_dqs_n
		output wire [0:0]  mem_odt,                                    //                            .mem_odt
		input  wire        oct_rzqin,                                         //                         oct.rzqin
		input  wire        global_reset_n                                     //                       reset.reset_n
	);
    NiosIISystem u0 (
        .clk_clk                                           (pll_ref_clk),                                           //                         clk.clk
        .led_pio_external_connection_export                (led_pio),                // led_pio_external_connection.export
        .memory_mem_a                                      (mem_a),                                      //                      memory.mem_a
        .memory_mem_ba                                     (mem_ba),                                     //                            .mem_ba
        .memory_mem_ck                                     (mem_ck),                                     //                            .mem_ck
        .memory_mem_ck_n                                   (mem_ck_n),                                   //                            .mem_ck_n
        .memory_mem_cke                                    (mem_cke),                                    //                            .mem_cke
        .memory_mem_cs_n                                   (mem_cs_n),                                   //                            .mem_cs_n
        .memory_mem_dm                                     (mem_dm),                                     //                            .mem_dm
        .memory_mem_ras_n                                  (mem_ras_n),                                  //                            .mem_ras_n
        .memory_mem_cas_n                                  (mem_cas_n),                                  //                            .mem_cas_n
        .memory_mem_we_n                                   (mem_we_n),                                   //                            .mem_we_n
        .memory_mem_reset_n                                (mem_reset_n),                                //                            .mem_reset_n
        .memory_mem_dq                                     (mem_dq),                                     //                            .mem_dq
        .memory_mem_dqs                                    (mem_dqs),                                    //                            .mem_dqs
        .memory_mem_dqs_n                                  (mem_dqs_n),                                  //                            .mem_dqs_n
        .memory_mem_odt                                    (mem_odt),                                    //                            .mem_odt
        .oct_rzqin                                         (oct_rzqin),                                  //                         oct.rzqin
        .reset_reset_n                                     (global_reset_n),                             //                       reset.reset_n
	 );

endmodule
