module mux7seg(
	input wire a, b, c, d,  // 4-bit input as individual wires
	output wire [6:0] s     // 7-segment display output (active low)
);

reg [6:0] segments;        // Internal register to hold segment states

// Continuous assignment to connect segments to output s

assign s = segments;

// Always block to evaluate on changes to inputs a, b, c, or d

always @(a, b, c, d) begin // Case statement to determine segments based on binary input
	
	case ({a, b, c, d})

            4'b0000: segments = 7'b1000000; // 0

            4'b0001: segments = 7'b1111001; // 1

            4'b0010: segments = 7'b0100100; // 2

            4'b0011: segments = 7'b0110000; // 3

            4'b0100: segments = 7'b0011001; // 4

            4'b0101: segments = 7'b0010010; // 5

            4'b0110: segments = 7'b0000010; // 6

            4'b0111: segments = 7'b1111000; // 7

            4'b1000: segments = 7'b0000000; // 8

            4'b1001: segments = 7'b0010000; // 9

				4'b1010: segments = 7'b0001000; // A (10)

            4'b1011: segments = 7'b0000011; // b (11)

            4'b1100: segments = 7'b1000110; // C (12)

            4'b1101: segments = 7'b0100001; // d (13)

            4'b1110: segments = 7'b0000110; // E (14)

            4'b1111: segments = 7'b0111111; // - (out of range)

            default: segments = 7'b1111111; // Blank (all segments off)

	endcase
end

endmodule