module vga_graphics (
    input wire clk,                  // clock = 50MHz
    input wire [9:0] h_count,        // posizione x in cui disegno
    input wire [9:0] v_count,        // posizione y in cui disegno
	 input wire green_pix,            // pixel letti dalla ROM su cui è caricata l'immagine di sfondo
	 input wire video_on,
	 input wire signed [7:0] sin_val, // associa ad ogni angolo un valore (due quadranti) -> ottimizzabile
	 input wire signed [7:0] cos_val, // associa ad ogni angolo un valore (due quadranti) -> ottimizzabile
	 input wire [11:0] distance,      // attenzione: è unsigned e riporta la distanza in mm
	 input wire new_data,   			 // prende in ingresso l'en del filtro mediano, ogni 0.5s, quindi 10 volte in 5s (180°)
	 input wire en,                   // gestisce on-off del radar
	 input wire reset_l,    			 // reset sincrono attivo basso
    output reg [3:0] R,
	 output reg [3:0] G,
	 output reg [3:0] B,
	 output reg [3:0] add_lut,		    // indirizzo lut corrente
	 output reg [17:0] rom_addr       // serve fino a 638*399 = 254,562,  18 bit bastano
);

   localparam IMG_W=638, IMG_H=399;
	localparam H_centro_circ = 320;
	localparam V_centro_circ = 320;   // 440 (fondo immagine) - 80 (distanza fondo dal centro della circonferenza)
	localparam H_VISIBLE = 640;       // 638x399 dimensione dell'immagine da rappresentare
	localparam V_VISIBLE = 480;
	reg [3:0]  lut_ref = 4'd0;
	reg [9:0]  x_val = H_centro_circ; // sempre positivi perchè rimetto offset del centro
	reg [9:0]  y_val = V_centro_circ;
	reg nd_reg1 = 1'b0;
	reg nd_reg2 = 1'b1;
	reg signed [12:0] distx = 13'd0;   // registro di appoggio per convertire distance da millimetri a cm (1px=1cm)
	
   always @(posedge clk) begin
	
	   nd_reg1 <= new_data;
		nd_reg2 <= ~nd_reg1;
		distx   <= (distance*819) >> 13;  // equivalente a divisione per dieci (mm -> cm)
		
		if(!reset_l) begin
			 add_lut <= 4'd0;
			 lut_ref <= 4'd0;
			 x_val   <= H_centro_circ;
			 y_val   <= V_centro_circ;
		end else begin
		    if (en && nd_reg1 && nd_reg2) begin
			     // >>> shift aritmetico che mantiene il segno, si usa un fattore 2^7 per memorizzare seno e coseno
				  x_val <= H_centro_circ + ((distx*cos_val) >>> 7);
				  y_val <= V_centro_circ - ((distx*sin_val) >>> 7);
			     
				  if(lut_ref < add_lut || lut_ref == 0 || add_lut == 0) begin  //scorro i settori
				
				      if (add_lut == 9) begin
					       add_lut <= add_lut-1;	// scambia i puntatori alla lut
						    lut_ref <= lut_ref;
					   end else begin
						    add_lut <= add_lut+1;	// prima avanti
						    lut_ref <= add_lut;
					   end
				  end else begin
					   add_lut <= add_lut-1;	   // poi indietro
					   lut_ref <= add_lut;
				  end
			 end else begin
			 	  add_lut <= add_lut;
			     lut_ref <= lut_ref;
				  x_val   <= x_val;
				  y_val   <= y_val;
			 end
	   end
		
		if (video_on) begin
			
		    // genero address per andare a pescare immagine di sfondo in memoria
          if (h_count < IMG_W && v_count < IMG_H) begin
			     rom_addr <= (v_count * IMG_W) + h_count;
		    end else rom_addr <= 18'd640;
				
			
			 // disegno in posizione bersaglio individuato, altrimenti sfondo
			 if (((h_count >= x_val-4) && (h_count <= x_val+3)) && ((v_count >= y_val-4)) && (v_count <= y_val+3))  // Disegna un punto rosso 8x8
		    begin
				  if (x_val !== H_centro_circ) begin
					   R <= 4'b1111;    // posizione bersaglio puntino rosso
					   B <= 4'b0000;
				      G <= 4'b0000;
				  end else begin
					   R <= 4'b0000;
					   B <= 4'b1111;    // fuori range puntino blu
				      G <= 4'b0000;
				  end
			 end else begin	     // condizione default, sfondo
				  R <= 4'b0000;
              if (green_pix) G <= 4'b1111;
				  else           G <= 4'b0000;
              B <= 4'b0000;
			 end
      end else begin // video_on = 0
			 rom_addr <= 18'd640;
			 R <= 4'b0000;
			 B <= 4'b0000;
			 G <= 4'b0000;
		end
   end
	
endmodule