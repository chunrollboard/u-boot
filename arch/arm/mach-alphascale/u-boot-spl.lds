/*
 * (C) Copyright 2002
 * Gary Jennejohn, DENX Software Engineering, <garyj@denx.de>
 *
 * (C) Copyright 2010
 * Texas Instruments, <www.ti.com>
 *	Aneesh V <aneesh@ti.com>
 *
 * (C) 2013 Atmel Corporation
 *	    Bo Shen <voice.shen@atmel.com>
 *
 * (C) 2014 2015, <chunrollboard.com>
 *	    Du Huanpeng <u74147@gmail.com>
 *
 * SPDX-License-Identifier:	GPL-2.0+
 */

MEMORY { SRAM0 (rwx): ORIGIN = 0x40000000, LENGTH = 4K }
MEMORY { SRAM1 (rwx): ORIGIN = 0x40001000, LENGTH = 4K }
MEMORY { SDRAM (rwx): ORIGIN = 0x00000000, LENGTH = 32M }

OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
	.text      :
	{
		__start = .;
		*(.vectors)
		arch/arm/cpu/arm926ejs/start.o (.text*)
		*(.text*)
	} >SRAM0

	. = ALIGN(4);
	.rodata : { *(SORT_BY_ALIGNMENT(.rodata*)) } >SRAM0

	. = ALIGN(4);
	.data : { *(SORT_BY_ALIGNMENT(.data*)) } >SRAM0

	. = ALIGN(4);
	__image_copy_end = .;

	.end :
	{
		*(.__end)
	} >SRAM0

	.bss :
	{
		. = ALIGN(4);
		__bss_start = .;
		*(.bss*)
		. = ALIGN(4);
		__bss_end = .;
	} >SRAM1
}
