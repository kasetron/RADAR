module validator  #(
	parameter MAXDIST = 12'd3000,
	parameter MINDIST = 12'd30
)(
	input [11:0] in,  // binary
	output reg valid  // 1 se il conteggio è compreso tra MIN e MAXCOUNT -> buono, 0 se satura a questi valori
);

always @ (*) begin
	if (in > MAXDIST || in < MINDIST) valid <= 1'b0;
	else valid <= 1'b1;
end

endmodule