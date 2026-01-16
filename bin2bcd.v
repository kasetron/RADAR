module bin2bcd (
	input [11:0] bin,  // binary
	output reg [15:0] bcd   // bcd {...,thousands,hundreds,tens,ones}
);

  integer i,j;

  always @ (bin) 
  begin
	 
	 bcd = 16'd0;   // <-- risolve definitivamente il warning
    bcd[12-1:0] = bin;
	 
	 // Di seguito codice originale; la modifica serve per inizializzare anche bcd[15], che non viene modificato
	 // dall'algoritmo causando così un warning. Formalmente è un errore, funzionalmente non crea nessun problema:
	 // con 12 bit rappresentiamo un valore massimo di 4095, dunque l'ultima cifra BCD arriva ad un valore massimo
	 // di 0100, in cui il bit più significativo (il quindicesimo) rimane sempre a zero.
	 
	 //for(i = 0; i <= 12+(12-4)/3; i = i+1) bcd[i] = 0;     // initialize with zeros
    //bcd[12-1:0] = bin;                                    // initialize with input vector
    
	 for(i = 0; i <= 12-4; i = i+1)                        // iterate on structure depth
      for(j = 0; j <= i/3; j = j+1)                       // iterate on structure width
        if (bcd[12-i+4*j -: 4] > 4)                       // if > 4
          bcd[12-i+4*j -: 4] = bcd[12-i+4*j -: 4] + 4'd3; // add 3
  end

endmodule