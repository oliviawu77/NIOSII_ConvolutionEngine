#set AlteraLib {c:/altera/81/modelsim_ae/altera/verilog/220model}
#set AlteraLib1 {c:/altera/81/modelsim_ae/altera/verilog/altera_mf}
vlib work
vmap work work

#compilation for library file required by ecc_decoder and true_dp_ram
vlog -work work {C:/intelFPGA_lite/18.0/quartus/eda/sim_lib/220model.v}
vlog -work work {C:/intelFPGA_lite/18.0/quartus/eda/sim_lib/altera_mf.v}


vlog -work work FPADD4.v
vlog -work work ValidPipeline.v
vlog -work work FPADD_Instruction.v
vlog -work work FPADD_Instruction_tb.v

vsim -t ps work.FPADD_Instruction_tb
#vsim -L $AlteraLib -L $AlteraLib1 -t ps work.top_dpram_vlg_vec_tst

view wave

add wave -binary /FPADD_Instruction_tb/clk
add wave -binary /FPADD_Instruction_tb/clk_en

add wave -binary /FPADD_Instruction_tb/reset

add wave -binary /FPADD_Instruction_tb/start

add wave -binary /FPADD_Instruction_tb/done

add wave -hexadecimal /FPADD_Instruction_tb/dataa
add wave -hexadecimal /FPADD_Instruction_tb/datab

add wave -hexadecimal /FPADD_Instruction_tb/result


run 900ps
wave zoomrange 0ps 1000ps
