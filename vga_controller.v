module vga_controller (
    input  wire      clk,       // clock = 50MHz MA clock pixel = 25 MHz
	 input  wire      enclk_pix, // funge da abilitazione -> dobbiamo usare un divisore (E-FF) per generarlo
    input  wire      reset_l,   // reset sincrono attivo basso
    output reg       hsync,     // sync orizzontale (active-low)
    output reg       vsync,     // sync verticale   (active-low)
    output wire      video_on,  // 1 quando siamo nell'area visibile
    output reg [9:0] h_count,   // coordinata X pixel 0..799
    output reg [9:0] v_count    // coordinata Y pixel 0..524
);

    // Parametri VGA 640x480 @60 Hz, vedi slide di Nannipieri

    localparam H_VISIBLE     = 640; 
    localparam H_FRONT_PORCH = 16;
    localparam H_SYNC_PULSE  = 96;
    localparam H_BACK_PORCH  = 48;
    localparam H_TOTAL       = 800; // H_VISIBLE + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH

    localparam V_VISIBLE     = 480;
    localparam V_FRONT_PORCH = 10;
    localparam V_SYNC_PULSE  = 2;
    localparam V_BACK_PORCH  = 33;
    localparam V_TOTAL       = 525; // V_VISIBLE + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH


    // Contatore orizzontale: avanza a ogni pixel, Contatore verticale: avanza a fine riga
    always @(posedge clk) begin
	     if (enclk_pix) begin
            if (!reset_l) begin
                h_count <= 10'd0;
            end else begin
                if (h_count == H_TOTAL-1) begin  // 799
                    h_count <= 10'd0;
						  if (v_count == V_TOTAL-1) v_count <= 10'd0; // 524
                    else v_count <= v_count + 1'b1;
                end else h_count <= h_count + 1'b1;
            end
        end else begin
		      h_count <= h_count;
				v_count <= v_count;
		  end
	 end


    // Generazione hsync / vsync (active-low)
    // hsync low quando h_count sta tra 656 e 751
    // vsync low quando v_count sta tra 490 e 491

    always @* begin
	     if (!reset_l) begin
		      hsync <= 1'b0;
				vsync <= 1'b0;
		  end else begin
            if (h_count < (H_VISIBLE + H_FRONT_PORCH) || h_count > (H_VISIBLE + H_FRONT_PORCH + H_SYNC_PULSE - 1))
                hsync <= 1'b1;
            else hsync <= 1'b0;
				if (v_count < (V_VISIBLE + V_FRONT_PORCH) || v_count > (V_VISIBLE + V_FRONT_PORCH + V_SYNC_PULSE - 1))
                vsync <= 1'b1;
            else vsync <= 1'b0;
		  end
    end


    // Area visibile + coordinate pixel
    
    assign video_on = ((h_count < H_VISIBLE) && (v_count < V_VISIBLE));

    // h_count = x 0..639 quando video_on=1
    // v_count = y 0..479 quando video_on=1

endmodule
