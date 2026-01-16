module dutycycle (
    input en,                       // en = enable per controllorare o meno il modulo
	 input reset_l,                  // reset sincrono attivo basso
    input clk,                      // clk a 50MHz
	 input tick_50hz,                // divisione del clock a 50Hz
    output reg [19:0] duty_cycle    // vedi parametri
);

    // ===== PWM SERVO PARAMETERS =====
    localparam MIN_DUTY  = 20'd25000;     // 0.5ms  0gradi
    localparam MID_DUTY  = 20'd75000;     // 1.5ms  90gradi
    localparam MAX_DUTY  = 20'd125000;    // 2.5ms  180gradi
	 localparam integer DELTA = 20'd400;   // incremento ogni 20 ms il duty di 400 (in 5s faccio 100000 di incremento (tutto il range))
    localparam integer STEPS = 250;       // 5s * 50 Hz

    reg [7:0] step_counter = 0;
    reg dir = 0;  // 0 = CW, 1 = CCW


    // ===== SWEEP =====
    always @(posedge clk) begin
        if (!reset_l) begin
            duty_cycle <= MIN_DUTY;  // posizione di partenza
            dir <= 0;
            step_counter <= 0;

        end else begin
		  if (en) begin
		      if (tick_50hz) begin  // aggiorna il valore di duty_cycle ogni 20ms, a 50hz
                if (!dir) begin
                    // verso destra (duty aumenta)
                    if (step_counter < STEPS-1) begin
                        duty_cycle <= duty_cycle + DELTA;
                        step_counter <= step_counter + 1;
                    end else begin
                        // fine: inverti
								duty_cycle <= duty_cycle + DELTA;
                        dir <= ~dir;
                        step_counter <= 0;
                    end
                end else begin
                    // verso sinistra (duty diminuisce)
                    if (step_counter < STEPS-1) begin
                        duty_cycle <= duty_cycle - DELTA;
                        step_counter <= step_counter + 1;
                    end else begin
                        // fine: inverti
								duty_cycle <= duty_cycle - DELTA;
                        dir <= ~dir;
                        step_counter <= 0;
                    end
                end
            end else begin
				    duty_cycle <= duty_cycle;
					 step_counter <= step_counter;
					 dir <= dir;
				end
		  end else begin
		      duty_cycle <= duty_cycle;      // mantenimento
				step_counter <= step_counter;
				dir <= dir;
		  end
        end
    end

endmodule