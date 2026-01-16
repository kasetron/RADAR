module pwm (
    input en,                 // en = enable per accendere il modulo
	 input reset_l,            // reset sincrono attivo basso
    input clk,                // clk a 50MHz
    input [19:0] duty_cycle,  // duty_cycle per pilotare il motore: 25000 (0.5ms) fino a 125000 (2.5ms)
    output reg pwm = 0,       // uscita impulsata
    output reg tick_50hz      // divisione del clock a 50Hz
);

    localparam integer TICK_50HZ_MAX = 1000000;  // vogliamo avere un impulsino ogni milione di fronti a 50MHz

    //contatore fino a 1000000 (20ms, @50MHz)
    reg [19:0] count = 0;

always @(posedge clk) begin
	if (!reset_l) begin
		count <= 0;
		pwm <= 0;
		tick_50hz <= 0;
	end else begin
	if (en) begin
		if (count == TICK_50HZ_MAX-1) begin
		    count <= 0;
			 tick_50hz <= 1;
		end else begin
		    count <= count + 1;
			 tick_50hz <= 0;
	   end
		
		pwm <= (count < duty_cycle) ? 1 : 0;
	end else begin
	   pwm <= pwm;              // mantenimento
		count <= count;
		tick_50hz <= tick_50hz;
	end
	end
end
    
endmodule