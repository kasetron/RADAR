// modulo non utilizzato: instanziata ROM dall'IP Catalogue di Quartus
module radar_rom (
	 input	   [17:0]  addr,  // 18 bit per massimo di 262144 elementi > 254562=638x399 (#pixel)
	 input	   clk,
	 output reg q              // pixel monochrome (on-off)
);

    localparam DATA_WIDTH=1,DEPTH = 262144;
	 
	 reg [DATA_WIDTH-1:0] rom [0:DEPTH-1];
	 
	 always @ (posedge clk) begin
	     if (addr<DEPTH) q <= rom[addr];
		  else q <= 1'b0;   // default
	 end
	 
	 // Inizializzazione della rom con $readmemb
	 initial begin
	     $readmemb("radar_green.txt", rom);
	 end

endmodule