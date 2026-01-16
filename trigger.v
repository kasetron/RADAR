module trigger (clk, rst_l, trig);
input clk;           // clock a 50MHz, periodo 20ns
input rst_l;         // reset sincrono attivo basso
output reg trig = 0; // segnale di trigger

// contatore 23 bit per contare fino a 5 000 000 
// (100 ms (10 µs per l'impulso di trigger + attesa) prima del prossimo impulso)
reg [22:0] count = 0;


always @(posedge clk) begin
    if (~rst_l) begin
        count <= 0;
        trig <= 0;
    end 
    
    else begin
        if (count == 4999999) count <= 0;
        else count <= count + 1;

        // impulso alto per i primi 10 µs
        trig <= (count < 500) ? 1 : 0;
    end
end

endmodule
