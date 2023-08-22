
module NiosIISystem (
	clk_clk,
	led_pio_external_connection_export,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_dm,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	oct_rzqin,
	reset_reset_n,
	uniphy_ddr3_pll_sharing_pll_mem_clk,
	uniphy_ddr3_pll_sharing_pll_write_clk,
	uniphy_ddr3_pll_sharing_pll_locked,
	uniphy_ddr3_pll_sharing_pll_write_clk_pre_phy_clk,
	uniphy_ddr3_pll_sharing_pll_addr_cmd_clk,
	uniphy_ddr3_pll_sharing_pll_avl_clk,
	uniphy_ddr3_pll_sharing_pll_config_clk,
	uniphy_ddr3_pll_sharing_pll_mem_phy_clk,
	uniphy_ddr3_pll_sharing_afi_phy_clk,
	uniphy_ddr3_pll_sharing_pll_avl_phy_clk,
	uniphy_ddr3_status_local_init_done,
	uniphy_ddr3_status_local_cal_success,
	uniphy_ddr3_status_local_cal_fail);	

	input		clk_clk;
	output	[7:0]	led_pio_external_connection_export;
	output	[12:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output	[0:0]	memory_mem_ck;
	output	[0:0]	memory_mem_ck_n;
	output	[0:0]	memory_mem_cke;
	output	[0:0]	memory_mem_cs_n;
	output	[0:0]	memory_mem_dm;
	output	[0:0]	memory_mem_ras_n;
	output	[0:0]	memory_mem_cas_n;
	output	[0:0]	memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[7:0]	memory_mem_dq;
	inout	[0:0]	memory_mem_dqs;
	inout	[0:0]	memory_mem_dqs_n;
	output	[0:0]	memory_mem_odt;
	input		oct_rzqin;
	input		reset_reset_n;
	output		uniphy_ddr3_pll_sharing_pll_mem_clk;
	output		uniphy_ddr3_pll_sharing_pll_write_clk;
	output		uniphy_ddr3_pll_sharing_pll_locked;
	output		uniphy_ddr3_pll_sharing_pll_write_clk_pre_phy_clk;
	output		uniphy_ddr3_pll_sharing_pll_addr_cmd_clk;
	output		uniphy_ddr3_pll_sharing_pll_avl_clk;
	output		uniphy_ddr3_pll_sharing_pll_config_clk;
	output		uniphy_ddr3_pll_sharing_pll_mem_phy_clk;
	output		uniphy_ddr3_pll_sharing_afi_phy_clk;
	output		uniphy_ddr3_pll_sharing_pll_avl_phy_clk;
	output		uniphy_ddr3_status_local_init_done;
	output		uniphy_ddr3_status_local_cal_success;
	output		uniphy_ddr3_status_local_cal_fail;
endmodule
