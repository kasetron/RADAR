module median_filter (
    input             clk,
    input             en_mf,
    input  [11:0]     in0, in1, in2, in3, in4,
    output reg [11:0] out
);

    reg [11:0] m0, m1, m2, m3, m4;

    reg [2:0] state = 3'd0;
    localparam S0=3'd0, S1=3'd1, S2=3'd2, S3=3'd3, S4=3'd4, S5=3'd5, S6=3'd6;

    // FSM + datapath
    always @(posedge clk) begin
        case (state)

            // -------------------
            // Load inputs
            // -------------------
            S0: begin
                m0 <= in0; m1 <= in1; m2 <= in2; m3 <= in3; m4 <= in4;
                state <= S1;
            end

            // -------------------
            // Step 1
            // -------------------
            S1: begin
                if (m0 > m1) begin m0 <= m1; m1 <= m0; end
                if (m3 > m4) begin m3 <= m4; m4 <= m3; end
                state <= S2;
            end

            // -------------------
            // Step 2
            // -------------------
            S2: begin
                if (m2 > m4) begin m2 <= m4; m4 <= m2; end
                if (m0 > m3) begin m0 <= m3; m3 <= m0; end
                state <= S3;
            end

            // -------------------
            // Step 3
            // -------------------
            S3: begin
                if (m2 > m3) begin m2 <= m3; m3 <= m2; end
                if (m1 > m4) begin m1 <= m4; m4 <= m1; end
                state <= S4;
            end
            
            // -------------------
            // Step 4
            // -------------------
            S4: begin
                if (m0 > m2) begin m0 <= m2; m2 <= m0; end
                if (m1 > m3) begin m1 <= m3; m3 <= m1; end
                state <= S5;
            end

            // -------------------
            // Step 5
            // -------------------
            S5: begin
                if (m1 > m2) begin m1 <= m2; m2 <= m1; end
                state <= S6;
            end

            // -------------------
            // Step 6 : output
            // -------------------
            S6: begin
                if (en_mf) begin
                    out <= m2;
                    state <= S0;
                end else begin
                    state <= S6;
                    out <= out;
                end
            end

            // -------------------
            // default
            // -------------------
	    default: begin
                    state <= S0;
                    out <= 12'd0;
            end
        endcase


    end

endmodule