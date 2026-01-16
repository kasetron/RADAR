module freqdivider (
    input clk,
    output reg clk_div
);
    parameter F = 2;

    // contatore
    reg [$clog2(F)-1:0] count = 0;

    always @(posedge clk) begin
        if (count == F - 1) begin
            count <= 1'b0;
            clk_div <= 1;
        end else begin
            count <= count + 1'b1;
				clk_div <= 1'b0;
        end
    end
endmodule
