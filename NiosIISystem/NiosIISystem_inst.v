	NiosIISystem u0 (
		.clk_clk                                           (<connected-to-clk_clk>),                                           //                         clk.clk
		.led_pio_external_connection_export                (<connected-to-led_pio_external_connection_export>),                // led_pio_external_connection.export
		.memory_mem_a                                      (<connected-to-memory_mem_a>),                                      //                      memory.mem_a
		.memory_mem_ba                                     (<connected-to-memory_mem_ba>),                                     //                            .mem_ba
		.memory_mem_ck                                     (<connected-to-memory_mem_ck>),                                     //                            .mem_ck
		.memory_mem_ck_n                                   (<connected-to-memory_mem_ck_n>),                                   //                            .mem_ck_n
		.memory_mem_cke                                    (<connected-to-memory_mem_cke>),                                    //                            .mem_cke
		.memory_mem_cs_n                                   (<connected-to-memory_mem_cs_n>),                                   //                            .mem_cs_n
		.memory_mem_dm                                     (<connected-to-memory_mem_dm>),                                     //                            .mem_dm
		.memory_mem_ras_n                                  (<connected-to-memory_mem_ras_n>),                                  //                            .mem_ras_n
		.memory_mem_cas_n                                  (<connected-to-memory_mem_cas_n>),                                  //                            .mem_cas_n
		.memory_mem_we_n                                   (<connected-to-memory_mem_we_n>),                                   //                            .mem_we_n
		.memory_mem_reset_n                                (<connected-to-memory_mem_reset_n>),                                //                            .mem_reset_n
		.memory_mem_dq                                     (<connected-to-memory_mem_dq>),                                     //                            .mem_dq
		.memory_mem_dqs                                    (<connected-to-memory_mem_dqs>),                                    //                            .mem_dqs
		.memory_mem_dqs_n                                  (<connected-to-memory_mem_dqs_n>),                                  //                            .mem_dqs_n
		.memory_mem_odt                                    (<connected-to-memory_mem_odt>),                                    //                            .mem_odt
		.oct_rzqin                                         (<connected-to-oct_rzqin>),                                         //                         oct.rzqin
		.reset_reset_n                                     (<connected-to-reset_reset_n>),                                     //                       reset.reset_n
		.uniphy_ddr3_pll_sharing_pll_mem_clk               (<connected-to-uniphy_ddr3_pll_sharing_pll_mem_clk>),               //     uniphy_ddr3_pll_sharing.pll_mem_clk
		.uniphy_ddr3_pll_sharing_pll_write_clk             (<connected-to-uniphy_ddr3_pll_sharing_pll_write_clk>),             //                            .pll_write_clk
		.uniphy_ddr3_pll_sharing_pll_locked                (<connected-to-uniphy_ddr3_pll_sharing_pll_locked>),                //                            .pll_locked
		.uniphy_ddr3_pll_sharing_pll_write_clk_pre_phy_clk (<connected-to-uniphy_ddr3_pll_sharing_pll_write_clk_pre_phy_clk>), //                            .pll_write_clk_pre_phy_clk
		.uniphy_ddr3_pll_sharing_pll_addr_cmd_clk          (<connected-to-uniphy_ddr3_pll_sharing_pll_addr_cmd_clk>),          //                            .pll_addr_cmd_clk
		.uniphy_ddr3_pll_sharing_pll_avl_clk               (<connected-to-uniphy_ddr3_pll_sharing_pll_avl_clk>),               //                            .pll_avl_clk
		.uniphy_ddr3_pll_sharing_pll_config_clk            (<connected-to-uniphy_ddr3_pll_sharing_pll_config_clk>),            //                            .pll_config_clk
		.uniphy_ddr3_pll_sharing_pll_mem_phy_clk           (<connected-to-uniphy_ddr3_pll_sharing_pll_mem_phy_clk>),           //                            .pll_mem_phy_clk
		.uniphy_ddr3_pll_sharing_afi_phy_clk               (<connected-to-uniphy_ddr3_pll_sharing_afi_phy_clk>),               //                            .afi_phy_clk
		.uniphy_ddr3_pll_sharing_pll_avl_phy_clk           (<connected-to-uniphy_ddr3_pll_sharing_pll_avl_phy_clk>),           //                            .pll_avl_phy_clk
		.uniphy_ddr3_status_local_init_done                (<connected-to-uniphy_ddr3_status_local_init_done>),                //          uniphy_ddr3_status.local_init_done
		.uniphy_ddr3_status_local_cal_success              (<connected-to-uniphy_ddr3_status_local_cal_success>),              //                            .local_cal_success
		.uniphy_ddr3_status_local_cal_fail                 (<connected-to-uniphy_ddr3_status_local_cal_fail>)                  //                            .local_cal_fail
	);

