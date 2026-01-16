module motor_tb;

// === Dichiarazione segnali di test ===
reg MAX10_CLK1_50;
reg SW;
wire GPIO;

// === Istanza del modulo da testare ===
motor uut (
    .SW(SW),
    .MAX10_CLK1_50(MAX10_CLK1_50),
    .GPIO(GPIO)
);

wire [5:0] control_pwm = uut.SYNTHESIZED_WIRE_1;
wire internal_clk = uut.SYNTHESIZED_WIRE_0;

// === Generazione clock 50 MHz ===
// periodo = 20 ns → 50 MHz
always #1 MAX10_CLK1_50 = ~MAX10_CLK1_50;

// === Stimoli di test ===
initial begin
    // Inizializzazione
    MAX10_CLK1_50 = 0;
    SW = 0;

    // Attesa iniziale
    #100;

    // Abilita PWM
    SW = 1;

    
    #10000;

    $stop; // Ferma la simulazione
end

endmodule
