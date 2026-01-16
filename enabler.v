module enabler (
    input clk,
	 input in,
    output reg en
);

    // contatore
    reg [2:0] count = 0;

    initial begin
        en = 1'b0;   // evita StX
    end

always @(posedge clk) begin
	 if (in) begin
        if (count == 4) begin
            count <= 0;
            en <= 1'b1;  // si alza ogni 5 nuovi dati dal sensore
        end else begin
            count <= count + 1;
				en <= 1'b0;
        end
	 end else begin
		  en <= en;
		  count <= count;
	 end
end
endmodule
