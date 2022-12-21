current_dir := ${CURDIR}
TOP := test_32bit
TARGET := nexys4ddr
SOURCES := ${current_dir}/build/combined.vhd

REAL_SOURCES := $(wildcard *.vhd) $(wildcard bootloader/*.vhd) $(filter-out cu/tb_*.vhd,$(wildcard cu/*.vhd)) $(wildcard segmentdisp/*.vhd) $(wildcard switches/*.vhd)

XDC := ${current_dir}/nexys4ddr.xdc

include common.mk

${SOURCES}: ${REAL_SOURCES} | ${current_dir}/build
	cat ${REAL_SOURCES} > $@
	
${current_dir}/build:
	mkdir -p $@