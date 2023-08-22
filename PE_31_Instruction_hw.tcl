# TCL File Generated by Component Editor 18.0
# Wed Jun 14 10:55:25 CST 2023
# DO NOT MODIFY


# 
# PE_31_Instruction "PE_31_Instruction" v1.0
#  2023.06.14.10:55:25
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module PE_31_Instruction
# 
set_module_property DESCRIPTION ""
set_module_property NAME PE_31_Instruction
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME PE_31_Instruction
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL PE_31_Instruction
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file ACC.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/ACC.v
add_fileset_file Buffer.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/Buffer.v
add_fileset_file FIFO_Buffer.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/FIFO_Buffer.v
add_fileset_file FIFO_Buffer2.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/FIFO_Buffer2.v
add_fileset_file FIFO_Buffer_ACC.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/FIFO_Buffer_ACC.v
add_fileset_file FPADD.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/FPADD.v
add_fileset_file FPMUL.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/FPMUL.v
add_fileset_file MAC_Pipeline.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/MAC_Pipeline.v
add_fileset_file NOPPipeline.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/NOPPipeline.v
add_fileset_file OutputDataPipeline.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/OutputDataPipeline.v
add_fileset_file PE.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/PE.v
add_fileset_file PE_31_Instruction.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/PE_31_Instruction.v TOP_LEVEL_FILE
add_fileset_file Pointer.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/Pointer.v
add_fileset_file Ready_16.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/Ready_16.v
add_fileset_file Ready_4.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/Ready_4.v
add_fileset_file Round.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/Round.v
add_fileset_file ValidPipeline.v VERILOG PATH ../../../Users/M0929010/Desktop/PE_Group_Instruction/ValidPipeline.v


# 
# parameters
# 
add_parameter DataWidth INTEGER 32
set_parameter_property DataWidth DEFAULT_VALUE 32
set_parameter_property DataWidth DISPLAY_NAME DataWidth
set_parameter_property DataWidth TYPE INTEGER
set_parameter_property DataWidth UNITS None
set_parameter_property DataWidth HDL_PARAMETER true


# 
# display items
# 


# 
# connection point nios_custom_instruction_slave
# 
add_interface nios_custom_instruction_slave nios_custom_instruction end
set_interface_property nios_custom_instruction_slave clockCycle 0
set_interface_property nios_custom_instruction_slave operands 1
set_interface_property nios_custom_instruction_slave ENABLED true
set_interface_property nios_custom_instruction_slave EXPORT_OF ""
set_interface_property nios_custom_instruction_slave PORT_NAME_MAP ""
set_interface_property nios_custom_instruction_slave CMSIS_SVD_VARIABLES ""
set_interface_property nios_custom_instruction_slave SVD_ADDRESS_GROUP ""

add_interface_port nios_custom_instruction_slave clk clk Input 1
add_interface_port nios_custom_instruction_slave clk_en clk_en Input 1
add_interface_port nios_custom_instruction_slave reset reset Input 1
add_interface_port nios_custom_instruction_slave start start Input 1
add_interface_port nios_custom_instruction_slave done done Output 1
add_interface_port nios_custom_instruction_slave dataa dataa Input DataWidth
add_interface_port nios_custom_instruction_slave result result Output DataWidth
add_interface_port nios_custom_instruction_slave n n Input 3

