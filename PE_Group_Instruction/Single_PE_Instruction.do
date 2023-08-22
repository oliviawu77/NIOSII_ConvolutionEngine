#set AlteraLib {c:/altera/81/modelsim_ae/altera/verilog/220model}
#set AlteraLib1 {c:/altera/81/modelsim_ae/altera/verilog/altera_mf}
vlib work
vmap work work

vlog -work work {C:/intelFPGA_lite/18.0/quartus/eda/sim_lib/220model.v}
vlog -work work {C:/intelFPGA_lite/18.0/quartus/eda/sim_lib/altera_mf.v}

vlog -work work Buffer.v
vlog -work work Pointer.v
vlog -work work Round.v
vlog -work work Ready_16.v
vlog -work work Ready_4.v

vlog -work work FIFO_Buffer.v
vlog -work work FIFO_Buffer2.v
vlog -work work FIFO_Buffer_ACC.v
vlog -work work MAC_Pipeline.v

vlog -work work FPMUL.v
vlog -work work FPADD.v
vlog -work work OutputDataPipeline.v
vlog -work work NOPPipeline.v
vlog -work work ValidPipeline.v

vlog -work work PE.v
vlog -work work ACC.v
vlog -work work Single_PE_Instruction.v
vlog -work work Single_PE_Instruction_tb.v

vsim -t ps work.Single_PE_Instruction_tb
#vsim -L $AlteraLib -L $AlteraLib1 -t ps work.top_dpram_vlg_vec_tst

view wave

add wave -binary /Single_PE_Instruction_tb/clk
add wave -binary /Single_PE_Instruction_tb/clk_en

add wave -binary /Single_PE_Instruction_tb/rst

add wave -binary /Single_PE_Instruction_tb/start
add wave -unsigned /Single_PE_Instruction_tb/n

add wave -binary /Single_PE_Instruction_tb/done

add wave -hexadecimal /Single_PE_Instruction_tb/dataa

add wave -hexadecimal /Single_PE_Instruction_tb/result

run 900ns
wave zoomrange 0ps 1000ns
