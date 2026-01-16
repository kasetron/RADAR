// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
// CREATED		"Tue Jan 06 00:13:33 2026"

module ritardatore(
	in,
	clk,
	out
);


input wire	in;
input wire	clk;
output wire	out;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;





dff_base	b2v_inst(
	.d(in),
	.clk(clk),
	.q(SYNTHESIZED_WIRE_1));


dff_base	b2v_inst10(
	.d(SYNTHESIZED_WIRE_0),
	.clk(clk),
	.q(out));


dff_base	b2v_inst4(
	.d(SYNTHESIZED_WIRE_1),
	.clk(clk),
	.q(SYNTHESIZED_WIRE_2));


dff_base	b2v_inst5(
	.d(SYNTHESIZED_WIRE_2),
	.clk(clk),
	.q(SYNTHESIZED_WIRE_3));


dff_base	b2v_inst6(
	.d(SYNTHESIZED_WIRE_3),
	.clk(clk),
	.q(SYNTHESIZED_WIRE_4));


dff_base	b2v_inst7(
	.d(SYNTHESIZED_WIRE_4),
	.clk(clk),
	.q(SYNTHESIZED_WIRE_5));


dff_base	b2v_inst8(
	.d(SYNTHESIZED_WIRE_5),
	.clk(clk),
	.q(SYNTHESIZED_WIRE_6));


dff_base	b2v_inst9(
	.d(SYNTHESIZED_WIRE_6),
	.clk(clk),
	.q(SYNTHESIZED_WIRE_0));


endmodule
