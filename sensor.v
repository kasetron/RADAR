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
// CREATED		"Tue Jan 06 00:09:09 2026"

module sensor(
	MAX10_CLK1_50,
	reset_l,
	GPIO,
	Trig_out,
	new_data,
	distance,
	HEX0,
	HEX1,
	HEX2,
	HEX3
);


input wire	MAX10_CLK1_50;
input wire	reset_l;
input wire	[3:3] GPIO;
output wire	Trig_out;
output wire	new_data;
output wire	[11:0] distance;
output wire	[6:0] HEX0;
output wire	[6:0] HEX1;
output wire	[6:0] HEX2;
output wire	[6:0] HEX3;

wire	[15:0] BCD;
wire	clk;
wire	SYNTHESIZED_WIRE_16;
wire	[11:0] SYNTHESIZED_WIRE_1;
wire	[11:0] SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_18;
wire	[15:0] SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_19;
wire	[11:0] SYNTHESIZED_WIRE_8;
wire	[11:0] SYNTHESIZED_WIRE_9;
wire	[11:0] SYNTHESIZED_WIRE_10;
wire	[11:0] SYNTHESIZED_WIRE_11;
wire	[11:0] SYNTHESIZED_WIRE_12;





SR	b2v_inst(
	.clk(clk),
	.en_sr(SYNTHESIZED_WIRE_16),
	.data_in(SYNTHESIZED_WIRE_1),
	.data_0(SYNTHESIZED_WIRE_8),
	.data_1(SYNTHESIZED_WIRE_9),
	.data_2(SYNTHESIZED_WIRE_10),
	.data_3(SYNTHESIZED_WIRE_11),
	.data_out(SYNTHESIZED_WIRE_12));


enabler	b2v_inst1(
	.clk(clk),
	.in(SYNTHESIZED_WIRE_16),
	.en(SYNTHESIZED_WIRE_19));


echo	b2v_inst10(
	.clk(clk),
	.rst_l(reset_l),
	.echo(GPIO),
	.en_sr(SYNTHESIZED_WIRE_16),
	.distance(SYNTHESIZED_WIRE_1));


bin2bcd	b2v_inst11(
	.bin(SYNTHESIZED_WIRE_17),
	.bcd(SYNTHESIZED_WIRE_5));


mux_valid	b2v_inst12(
	.valid(SYNTHESIZED_WIRE_18),
	.in(SYNTHESIZED_WIRE_5),
	.out(BCD));


ritardatore	b2v_inst13(
	.in(SYNTHESIZED_WIRE_19),
	.clk(clk),
	.out(new_data));


trigger	b2v_inst2(
	.clk(clk),
	.rst_l(reset_l),
	.trig(Trig_out));


mux7seg	b2v_inst3(
	.a(BCD[11]),
	.b(BCD[10]),
	.c(BCD[9]),
	.d(BCD[8]),
	.s(HEX2));


mux7seg	b2v_inst4(
	.a(BCD[3]),
	.b(BCD[2]),
	.c(BCD[1]),
	.d(BCD[0]),
	.s(HEX0));


mux7seg	b2v_inst5(
	.a(BCD[7]),
	.b(BCD[6]),
	.c(BCD[5]),
	.d(BCD[4]),
	.s(HEX1));


mux7seg	b2v_inst6(
	.a(BCD[15]),
	.b(BCD[14]),
	.c(BCD[13]),
	.d(BCD[12]),
	.s(HEX3));


median_filter	b2v_inst7(
	.clk(clk),
	.en_mf(SYNTHESIZED_WIRE_19),
	.in0(SYNTHESIZED_WIRE_8),
	.in1(SYNTHESIZED_WIRE_9),
	.in2(SYNTHESIZED_WIRE_10),
	.in3(SYNTHESIZED_WIRE_11),
	.in4(SYNTHESIZED_WIRE_12),
	.out(SYNTHESIZED_WIRE_17));


validator	b2v_inst8(
	.in(SYNTHESIZED_WIRE_17),
	.valid(SYNTHESIZED_WIRE_18));
	defparam	b2v_inst8.MAXDIST = 12'b101110111000;
	defparam	b2v_inst8.MINDIST = 12'b000000011110;


mux_valid_12bit	b2v_inst9(
	.valid(SYNTHESIZED_WIRE_18),
	.in(SYNTHESIZED_WIRE_17),
	.out(distance));

assign	clk = MAX10_CLK1_50;

endmodule
