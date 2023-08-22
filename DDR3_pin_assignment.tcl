set_instance_assignment -name IO_STANDARD "LVDS" -to pll_ref_clk
set_instance_assignment -name IO_STANDARD "2.5V" -to global_reset_n

set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to led_pio[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to led_pio[1]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to led_pio[2]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to led_pio[3]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to led_pio[4]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to led_pio[5]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to led_pio[6]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to led_pio[7]

set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_a[12]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_a[11]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_a[10]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_a[9]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_a[8]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_a[7]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_a[6]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_a[5]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_a[4]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_a[3]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_a[2]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_a[1]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_a[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_ba[2]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_ba[1]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_ba[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_cas_n[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_cke[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_cs_n[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_dm[1]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_dm[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_dq[7]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_dq[6]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_dq[5]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_dq[4]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_dq[3]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_dq[2]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_dq[1]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_dq[0]

set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_odt[0]
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_ras_n[0]
set_instance_assignment -name IO_STANDARD "1.5 V" -to mem_reset_n
set_instance_assignment -name IO_STANDARD "SSTL-15 Class I" -to mem_we_n[0]
set_instance_assignment -name IO_STANDARD "SSTL-15" -to oct_rzqin

#set_location_assignment PIN_AN13 -to mem_a[13]
set_location_assignment PIN_AM13 -to mem_a[12]
set_location_assignment PIN_AM16 -to mem_a[11]
set_location_assignment PIN_AL16 -to mem_a[10]
set_location_assignment PIN_AJ16 -to mem_a[9]
set_location_assignment PIN_AH16 -to mem_a[8]
set_location_assignment PIN_AL17 -to mem_a[7]
set_location_assignment PIN_AK17 -to mem_a[6]
set_location_assignment PIN_AJ17 -to mem_a[5]
set_location_assignment PIN_AH17 -to mem_a[4]
set_location_assignment PIN_AN18 -to mem_a[3]
set_location_assignment PIN_AM18 -to mem_a[2]
set_location_assignment PIN_AL18 -to mem_a[1]
set_location_assignment PIN_AK18 -to mem_a[0]
set_location_assignment PIN_AP17 -to mem_ba[2]
set_location_assignment PIN_AN17 -to mem_ba[1]
set_location_assignment PIN_AN16 -to mem_ba[0]
set_location_assignment PIN_AP15 -to mem_cas_n[0]
set_location_assignment PIN_AA18 -to mem_ck[0]
set_location_assignment PIN_AA17 -to mem_ck_n[0]
set_location_assignment PIN_AP26 -to mem_cke[0]
set_location_assignment PIN_AA16 -to mem_cs_n[0]
#set_location_assignment PIN_AM24 -to mem_dm[1]
set_location_assignment PIN_AL21 -to mem_dm[0]
#set_location_assignment PIN_AN24 -to mem_dq[15]
#set_location_assignment PIN_AN26 -to mem_dq[14]
#set_location_assignment PIN_AP25 -to mem_dq[13]
#set_location_assignment PIN_AP24 -to mem_dq[12]
#set_location_assignment PIN_AN23 -to mem_dq[11]
#set_location_assignment PIN_AN22 -to mem_dq[10]
#set_location_assignment PIN_AL20 -to mem_dq[9]
#set_location_assignment PIN_AM20 -to mem_dq[8]
set_location_assignment PIN_AM21 -to mem_dq[7]
set_location_assignment PIN_AJ19 -to mem_dq[6]
set_location_assignment PIN_AG19 -to mem_dq[5]
set_location_assignment PIN_AH19 -to mem_dq[4]
set_location_assignment PIN_AP21 -to mem_dq[3]
set_location_assignment PIN_AP20 -to mem_dq[2]
set_location_assignment PIN_AM19 -to mem_dq[1]
set_location_assignment PIN_AN19 -to mem_dq[0]
#set_location_assignment PIN_AD19 -to mem_dqs[1]
set_location_assignment PIN_AB19 -to mem_dqs[0]
#set_location_assignment PIN_AE19 -to mem_dqs_n[1]
set_location_assignment PIN_AC19 -to mem_dqs_n[0]
set_location_assignment PIN_AN21 -to mem_odt[0]
set_location_assignment PIN_AP14 -to mem_ras_n[0]
set_location_assignment PIN_AJ22 -to mem_reset_n
set_location_assignment PIN_AN12 -to mem_we_n[0]
set_location_assignment PIN_AP19 -to oct_rzqin
set_location_assignment PIN_AF18 -to pll_ref_clk
set_location_assignment PIN_AD29 -to global_reset_n

set_location_assignment PIN_AM23 -to led_pio[0]
set_location_assignment PIN_AE25 -to led_pio[1]
set_location_assignment PIN_AK29 -to led_pio[2]
set_location_assignment PIN_AL31 -to led_pio[3]
set_location_assignment PIN_AF25 -to led_pio[4]
set_location_assignment PIN_AJ27 -to led_pio[5]
set_location_assignment PIN_AC22 -to led_pio[6]
set_location_assignment PIN_AH27 -to led_pio[7]

set_location_assignment PIN_AD24 -to tristate_conduit_bridge_0_out_tcm_address_out[25]
set_location_assignment PIN_AH31 -to tristate_conduit_bridge_0_out_tcm_address_out[24]
set_location_assignment PIN_AK32 -to tristate_conduit_bridge_0_out_tcm_address_out[23]
set_location_assignment PIN_AM33 -to tristate_conduit_bridge_0_out_tcm_address_out[22]
set_location_assignment PIN_AF30 -to tristate_conduit_bridge_0_out_tcm_address_out[21]
set_location_assignment PIN_AN33 -to tristate_conduit_bridge_0_out_tcm_address_out[20]
set_location_assignment PIN_AG30 -to tristate_conduit_bridge_0_out_tcm_address_out[19]
set_location_assignment PIN_AJ30 -to tristate_conduit_bridge_0_out_tcm_address_out[18]
set_location_assignment PIN_AK30 -to tristate_conduit_bridge_0_out_tcm_address_out[17]
set_location_assignment PIN_AA30 -to tristate_conduit_bridge_0_out_tcm_address_out[16]
set_location_assignment PIN_AG29 -to tristate_conduit_bridge_0_out_tcm_address_out[15]
set_location_assignment PIN_AB30 -to tristate_conduit_bridge_0_out_tcm_address_out[14]
set_location_assignment PIN_AH28 -to tristate_conduit_bridge_0_out_tcm_address_out[13]
set_location_assignment PIN_AF28 -to tristate_conduit_bridge_0_out_tcm_address_out[12]
set_location_assignment PIN_AB29 -to tristate_conduit_bridge_0_out_tcm_address_out[11]
set_location_assignment PIN_AE28 -to tristate_conduit_bridge_0_out_tcm_address_out[10]
set_location_assignment PIN_AB28 -to tristate_conduit_bridge_0_out_tcm_address_out[9]
set_location_assignment PIN_AF26 -to tristate_conduit_bridge_0_out_tcm_address_out[8]
set_location_assignment PIN_AF27 -to tristate_conduit_bridge_0_out_tcm_address_out[7]
set_location_assignment PIN_Y25 -to tristate_conduit_bridge_0_out_tcm_address_out[6]
set_location_assignment PIN_Y24 -to tristate_conduit_bridge_0_out_tcm_address_out[5]
set_location_assignment PIN_AC28 -to tristate_conduit_bridge_0_out_tcm_address_out[4]
set_location_assignment PIN_AB23 -to tristate_conduit_bridge_0_out_tcm_address_out[3]
set_location_assignment PIN_AB24 -to tristate_conduit_bridge_0_out_tcm_address_out[2]
set_location_assignment PIN_AC27 -to tristate_conduit_bridge_0_out_tcm_address_out[1]
set_location_assignment PIN_AK33 -to tristate_conduit_bridge_0_out_tcm_address_out[0]

set_location_assignment PIN_AA21 -to tristate_conduit_bridge_0_out_tcm_chipselect_n_out[0]

set_location_assignment PIN_AL33 -to tristate_conduit_bridge_0_out_tcm_data_out[15]
set_location_assignment PIN_AC23 -to tristate_conduit_bridge_0_out_tcm_data_out[14]
set_location_assignment PIN_AC24 -to tristate_conduit_bridge_0_out_tcm_data_out[13]
set_location_assignment PIN_AL32 -to tristate_conduit_bridge_0_out_tcm_data_out[12]
set_location_assignment PIN_AA28 -to tristate_conduit_bridge_0_out_tcm_data_out[11]
set_location_assignment PIN_AA27 -to tristate_conduit_bridge_0_out_tcm_data_out[10]
set_location_assignment PIN_AH29 -to tristate_conduit_bridge_0_out_tcm_data_out[9]
set_location_assignment PIN_AG28 -to tristate_conduit_bridge_0_out_tcm_data_out[8]
set_location_assignment PIN_AA25 -to tristate_conduit_bridge_0_out_tcm_data_out[7]
set_location_assignment PIN_AB25 -to tristate_conduit_bridge_0_out_tcm_data_out[6]
set_location_assignment PIN_AC29 -to tristate_conduit_bridge_0_out_tcm_data_out[5]
set_location_assignment PIN_W24 -to tristate_conduit_bridge_0_out_tcm_data_out[4]
set_location_assignment PIN_Y22 -to tristate_conduit_bridge_0_out_tcm_data_out[3]
set_location_assignment PIN_Y23 -to tristate_conduit_bridge_0_out_tcm_data_out[2]
set_location_assignment PIN_AA23 -to tristate_conduit_bridge_0_out_tcm_data_out[1]
set_location_assignment PIN_AJ31 -to tristate_conduit_bridge_0_out_tcm_data_out[0]

set_location_assignment PIN_AG16 -to tristate_conduit_bridge_0_out_tcm_read_n_out[0]
set_location_assignment PIN_AM14 -to tristate_conduit_bridge_0_out_tcm_write_n_out[0]


































