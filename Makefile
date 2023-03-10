current_dir := ${CURDIR}
TOP := test_32bit
TARGET := nexys4ddr
SOURCES := ${current_dir}/build/combined.v

REAL_SOURCES := $(wildcard *.vhd) $(wildcard bootloader/*.vhd) $(filter-out cu/tb_*.vhd,$(wildcard cu/*.vhd)) $(wildcard segmentdisp/*.vhd) $(wildcard switches/*.vhd)

XDC := ${current_dir}/nexys4ddr.xdc

include common.mk

${current_dir}/build/combined.v: ${REAL_SOURCES} | ${current_dir}/build
	ghdl synth --out=verilog $^ -e ${TOP} > $@

${current_dir}/build:
	mkdir -p $@
