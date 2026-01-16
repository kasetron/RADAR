module mux_valid_12bit (
	input  valid,
	input  [11:0] in,  // binary
	output reg [11:0] out
);

always @ (*) begin
	case (valid)
		1'b0:    out <= 12'd0;
		1'b1:    out <= in;
		default: out <= 12'd0;
	endcase
end

endmodule