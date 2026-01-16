module mux_valid (
	input  valid,
	input  [15:0] in,  // binary
	output reg [15:0] out
);

always @ (*) begin
	case (valid)
		1'b0:    out <= 16'b1111111111111111;
		1'b1:    out <= in;
		default: out <= 16'b1111111111111111;
	endcase
end

endmodule