module dff_base (
	 input d,      // data input
    input clk,    // clock 50MHz
	 output reg q  // data output (registrato)
);

always @ (posedge clk) begin
    q <= d;
end

endmodule
