/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'cpu' in SOPC Builder design 'NiosIISystem'
 * SOPC Builder design path: ../../NiosIISystem.sopcinfo
 *
 * Generated: Sun Jul 09 07:01:27 CST 2023
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x04102820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 75000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1b
#define ALT_CPU_DCACHE_BYPASS_MASK 0x80000000
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 2048
#define ALT_CPU_EXCEPTION_ADDR 0x04080040
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 75000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_EXTRA_EXCEPTION_INFO
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 4096
#define ALT_CPU_INITDA_SUPPORTED
#define ALT_CPU_INST_ADDR_WIDTH 0x1b
#define ALT_CPU_NAME "cpu"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x04080020


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x04102820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 75000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x1b
#define NIOS2_DCACHE_BYPASS_MASK 0x80000000
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_EXCEPTION_ADDR 0x04080040
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_EXTRA_EXCEPTION_INFO
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_INITDA_SUPPORTED
#define NIOS2_INST_ADDR_WIDTH 0x1b
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x04080020


/*
 * Custom instruction macros
 *
 */

#define ALT_CI_PE_INSTRUCTION_0(n,A) __builtin_custom_ini(ALT_CI_PE_INSTRUCTION_0_N+(n&ALT_CI_PE_INSTRUCTION_0_N_MASK),(A))
#define ALT_CI_PE_INSTRUCTION_0_N 0x0
#define ALT_CI_PE_INSTRUCTION_0_N_MASK ((1<<3)-1)


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_DMA
#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PERFORMANCE_COUNTER
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_AVALON_TIMER
#define __ALTERA_MEM_IF_DDR3_EMIF
#define __ALTERA_NIOS2_GEN2
#define __PE_INSTRUCTION


/*
 * LED_pio configuration
 *
 */

#define ALT_MODULE_CLASS_LED_pio altera_avalon_pio
#define LED_PIO_BASE 0x4103080
#define LED_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define LED_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LED_PIO_CAPTURE 0
#define LED_PIO_DATA_WIDTH 8
#define LED_PIO_DO_TEST_BENCH_WIRING 0
#define LED_PIO_DRIVEN_SIM_VALUE 0
#define LED_PIO_EDGE_TYPE "NONE"
#define LED_PIO_FREQ 75000000
#define LED_PIO_HAS_IN 0
#define LED_PIO_HAS_OUT 1
#define LED_PIO_HAS_TRI 0
#define LED_PIO_IRQ -1
#define LED_PIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LED_PIO_IRQ_TYPE "NONE"
#define LED_PIO_NAME "/dev/LED_pio"
#define LED_PIO_RESET_VALUE 0
#define LED_PIO_SPAN 16
#define LED_PIO_TYPE "altera_avalon_pio"


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone V"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart"
#define ALT_STDERR_BASE 0x4103098
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_BASE 0x4103098
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_BASE 0x4103098
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "NiosIISystem"


/*
 * altera_hostfs configuration
 *
 */

#define ALTERA_HOSTFS_NAME "/mnt/host"


/*
 * dma configuration
 *
 */

#define ALT_MODULE_CLASS_dma altera_avalon_dma
#define DMA_ALLOW_BYTE_TRANSACTIONS 0
#define DMA_ALLOW_DOUBLEWORD_TRANSACTIONS 0
#define DMA_ALLOW_HW_TRANSACTIONS 0
#define DMA_ALLOW_QUADWORD_TRANSACTIONS 0
#define DMA_ALLOW_WORD_TRANSACTIONS 1
#define DMA_BASE 0x4103060
#define DMA_IRQ 1
#define DMA_IRQ_INTERRUPT_CONTROLLER_ID 0
#define DMA_LENGTHWIDTH 13
#define DMA_MAX_BURST_SIZE 128
#define DMA_NAME "/dev/dma"
#define DMA_SPAN 32
#define DMA_TYPE "altera_avalon_dma"


/*
 * dma_read_memory configuration
 *
 */

#define ALT_MODULE_CLASS_dma_read_memory altera_avalon_onchip_memory2
#define DMA_READ_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define DMA_READ_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define DMA_READ_MEMORY_BASE 0x4101000
#define DMA_READ_MEMORY_CONTENTS_INFO ""
#define DMA_READ_MEMORY_DUAL_PORT 0
#define DMA_READ_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define DMA_READ_MEMORY_INIT_CONTENTS_FILE "NiosIISystem_dma_read_memory"
#define DMA_READ_MEMORY_INIT_MEM_CONTENT 1
#define DMA_READ_MEMORY_INSTANCE_ID "NONE"
#define DMA_READ_MEMORY_IRQ -1
#define DMA_READ_MEMORY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DMA_READ_MEMORY_NAME "/dev/dma_read_memory"
#define DMA_READ_MEMORY_NON_DEFAULT_INIT_FILE_ENABLED 0
#define DMA_READ_MEMORY_RAM_BLOCK_TYPE "AUTO"
#define DMA_READ_MEMORY_READ_DURING_WRITE_MODE "DONT_CARE"
#define DMA_READ_MEMORY_SINGLE_CLOCK_OP 0
#define DMA_READ_MEMORY_SIZE_MULTIPLE 1
#define DMA_READ_MEMORY_SIZE_VALUE 4096
#define DMA_READ_MEMORY_SPAN 4096
#define DMA_READ_MEMORY_TYPE "altera_avalon_onchip_memory2"
#define DMA_READ_MEMORY_WRITABLE 1


/*
 * dma_read_memory configuration as viewed by dma_read_master
 *
 */

#define DMA_READ_MASTER_DMA_READ_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define DMA_READ_MASTER_DMA_READ_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define DMA_READ_MASTER_DMA_READ_MEMORY_BASE 0x4101000
#define DMA_READ_MASTER_DMA_READ_MEMORY_CONTENTS_INFO ""
#define DMA_READ_MASTER_DMA_READ_MEMORY_DUAL_PORT 0
#define DMA_READ_MASTER_DMA_READ_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define DMA_READ_MASTER_DMA_READ_MEMORY_INIT_CONTENTS_FILE "NiosIISystem_dma_read_memory"
#define DMA_READ_MASTER_DMA_READ_MEMORY_INIT_MEM_CONTENT 1
#define DMA_READ_MASTER_DMA_READ_MEMORY_INSTANCE_ID "NONE"
#define DMA_READ_MASTER_DMA_READ_MEMORY_IRQ -1
#define DMA_READ_MASTER_DMA_READ_MEMORY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DMA_READ_MASTER_DMA_READ_MEMORY_NAME "/dev/dma_read_memory"
#define DMA_READ_MASTER_DMA_READ_MEMORY_NON_DEFAULT_INIT_FILE_ENABLED 0
#define DMA_READ_MASTER_DMA_READ_MEMORY_RAM_BLOCK_TYPE "AUTO"
#define DMA_READ_MASTER_DMA_READ_MEMORY_READ_DURING_WRITE_MODE "DONT_CARE"
#define DMA_READ_MASTER_DMA_READ_MEMORY_SINGLE_CLOCK_OP 0
#define DMA_READ_MASTER_DMA_READ_MEMORY_SIZE_MULTIPLE 1
#define DMA_READ_MASTER_DMA_READ_MEMORY_SIZE_VALUE 4096
#define DMA_READ_MASTER_DMA_READ_MEMORY_SPAN 4096
#define DMA_READ_MASTER_DMA_READ_MEMORY_TYPE "altera_avalon_onchip_memory2"
#define DMA_READ_MASTER_DMA_READ_MEMORY_WRITABLE 1


/*
 * dma_read_memory configuration as viewed by dma_write_master
 *
 */

#define DMA_WRITE_MASTER_DMA_READ_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_BASE 0x4101000
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_CONTENTS_INFO ""
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_DUAL_PORT 0
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_INIT_CONTENTS_FILE "NiosIISystem_dma_read_memory"
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_INIT_MEM_CONTENT 1
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_INSTANCE_ID "NONE"
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_IRQ -1
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_NAME "/dev/dma_read_memory"
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_NON_DEFAULT_INIT_FILE_ENABLED 0
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_RAM_BLOCK_TYPE "AUTO"
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_READ_DURING_WRITE_MODE "DONT_CARE"
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_SINGLE_CLOCK_OP 0
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_SIZE_MULTIPLE 1
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_SIZE_VALUE 4096
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_SPAN 4096
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_TYPE "altera_avalon_onchip_memory2"
#define DMA_WRITE_MASTER_DMA_READ_MEMORY_WRITABLE 1


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 32
#define ALT_SYS_CLK TIMER
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart
#define JTAG_UART_BASE 0x4103098
#define JTAG_UART_IRQ 0
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_SPAN 8
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8


/*
 * onchip_memory configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_memory altera_avalon_onchip_memory2
#define ONCHIP_MEMORY_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY_BASE 0x4080000
#define ONCHIP_MEMORY_CONTENTS_INFO ""
#define ONCHIP_MEMORY_DUAL_PORT 0
#define ONCHIP_MEMORY_GUI_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY_INIT_CONTENTS_FILE "NiosIISystem_onchip_memory"
#define ONCHIP_MEMORY_INIT_MEM_CONTENT 1
#define ONCHIP_MEMORY_INSTANCE_ID "NONE"
#define ONCHIP_MEMORY_IRQ -1
#define ONCHIP_MEMORY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEMORY_NAME "/dev/onchip_memory"
#define ONCHIP_MEMORY_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEMORY_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY_SIZE_VALUE 524288
#define ONCHIP_MEMORY_SPAN 524288
#define ONCHIP_MEMORY_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEMORY_WRITABLE 1


/*
 * performance_counter_0 configuration
 *
 */

#define ALT_MODULE_CLASS_performance_counter_0 altera_avalon_performance_counter
#define PERFORMANCE_COUNTER_0_BASE 0x4103000
#define PERFORMANCE_COUNTER_0_HOW_MANY_SECTIONS 3
#define PERFORMANCE_COUNTER_0_IRQ -1
#define PERFORMANCE_COUNTER_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PERFORMANCE_COUNTER_0_NAME "/dev/performance_counter_0"
#define PERFORMANCE_COUNTER_0_SPAN 64
#define PERFORMANCE_COUNTER_0_TYPE "altera_avalon_performance_counter"


/*
 * sysid_qsys configuration
 *
 */

#define ALT_MODULE_CLASS_sysid_qsys altera_avalon_sysid_qsys
#define SYSID_QSYS_BASE 0x4103090
#define SYSID_QSYS_ID 0
#define SYSID_QSYS_IRQ -1
#define SYSID_QSYS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_QSYS_NAME "/dev/sysid_qsys"
#define SYSID_QSYS_SPAN 8
#define SYSID_QSYS_TIMESTAMP 1688833092
#define SYSID_QSYS_TYPE "altera_avalon_sysid_qsys"


/*
 * timer configuration
 *
 */

#define ALT_MODULE_CLASS_timer altera_avalon_timer
#define TIMER_ALWAYS_RUN 0
#define TIMER_BASE 0x4103040
#define TIMER_COUNTER_SIZE 32
#define TIMER_FIXED_PERIOD 0
#define TIMER_FREQ 75000000
#define TIMER_IRQ 2
#define TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMER_LOAD_VALUE 74999
#define TIMER_MULT 0.001
#define TIMER_NAME "/dev/timer"
#define TIMER_PERIOD 1
#define TIMER_PERIOD_UNITS "ms"
#define TIMER_RESET_OUTPUT 0
#define TIMER_SNAPSHOT 1
#define TIMER_SPAN 32
#define TIMER_TICKS_PER_SEC 1000
#define TIMER_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_TYPE "altera_avalon_timer"


/*
 * uniphy_ddr3 configuration
 *
 */

#define ALT_MODULE_CLASS_uniphy_ddr3 altera_mem_if_ddr3_emif
#define UNIPHY_DDR3_BASE 0x0
#define UNIPHY_DDR3_IRQ -1
#define UNIPHY_DDR3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define UNIPHY_DDR3_NAME "/dev/uniphy_ddr3"
#define UNIPHY_DDR3_SPAN 67108864
#define UNIPHY_DDR3_TYPE "altera_mem_if_ddr3_emif"


/*
 * uniphy_ddr3 configuration as viewed by dma_read_master
 *
 */

#define DMA_READ_MASTER_UNIPHY_DDR3_BASE 0x0
#define DMA_READ_MASTER_UNIPHY_DDR3_IRQ -1
#define DMA_READ_MASTER_UNIPHY_DDR3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DMA_READ_MASTER_UNIPHY_DDR3_NAME "/dev/uniphy_ddr3"
#define DMA_READ_MASTER_UNIPHY_DDR3_SPAN 67108864
#define DMA_READ_MASTER_UNIPHY_DDR3_TYPE "altera_mem_if_ddr3_emif"


/*
 * uniphy_ddr3 configuration as viewed by dma_write_master
 *
 */

#define DMA_WRITE_MASTER_UNIPHY_DDR3_BASE 0x0
#define DMA_WRITE_MASTER_UNIPHY_DDR3_IRQ -1
#define DMA_WRITE_MASTER_UNIPHY_DDR3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DMA_WRITE_MASTER_UNIPHY_DDR3_NAME "/dev/uniphy_ddr3"
#define DMA_WRITE_MASTER_UNIPHY_DDR3_SPAN 67108864
#define DMA_WRITE_MASTER_UNIPHY_DDR3_TYPE "altera_mem_if_ddr3_emif"

#endif /* __SYSTEM_H_ */
