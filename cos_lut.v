module cos_lut(
    input  [3:0] add_lut,       	   // indice LUT (0..15)
	 input  clk,
    output reg signed [7:0] cos_val // 10 valori
);

reg signed [7:0] lut [0:15];

//sono salvati i valori di coseno moltiplicati per 2^7

initial begin
    lut[0] = 8'b01111110; // 9° partendo da dx verso sx
    lut[1] = 8'b01110010; // 27°
    lut[2] = 8'b01011011; // 45°
    lut[3] = 8'b00111010; // 63°
    lut[4] = 8'b00010100; // 81°
    lut[5] = 8'b11101100; // 99°
    lut[6] = 8'b11000110; // 117°
    lut[7] = 8'b10100101; // 135°
    lut[8] = 8'b10001110; // 153°
    lut[9] = 8'b10000010; // 171°
	 // indirizzi vuoti
	 lut[10] = 8'd0;
	 lut[11] = 8'd0;
	 lut[12] = 8'd0;
	 lut[13] = 8'd0;
	 lut[14] = 8'd0;
	 lut[15] = 8'd0;
end

always @(posedge clk) begin
    cos_val <= lut[add_lut];
end

endmodule
