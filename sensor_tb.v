module sensor_tb;

    // ----------------------------
    // DUT signals
    // ----------------------------
    reg         MAX10_CLK1_50 = 0;   // 50 MHz clock
    reg         Trig_out = 0;        // trigger
    reg         SW = 0;              // reset (active low?)
    wire        GPIO;                // echo input
    wire [6:0]  HEX0;
    wire [6:0]  HEX1;
    wire [6:0]  HEX2;
    wire [6:0]  HEX3;

    // ----------------------------
    // Instantiate DUT
    // ------------------------------
    sensor dut (
        .MAX10_CLK1_50(MAX10_CLK1_50),
        .Trig_out(Trig_out),
        .SW(SW),
        .GPIO(GPIO),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3)
    );

    // ----------------------------
    // 50 MHz CLOCK
    // ----------------------------
    always #10 MAX10_CLK1_50 = ~MAX10_CLK1_50; // 20 ns → 50 MHz


    // ----------------------------
    // Utility task: simulate an echo pulse
    // duration_us = pulse width in microseconds (scaled)
    // ----------------------------
    task send_echo;
        input integer duration_us;
    begin
        GPIO <= 1'b1;
        #(duration_us * 1000);   // 1 us = 1000 ns in simulation
        GPIO <= 1'b0;
    end
    endtask
	 
    // ------------------------------------------------------------
    // FUNZIONI DI DECODIFICA 7-SEGMENT PER LA STAMPA DELLE CIFRE BCD
    // ------------------------------------------------------------
    function integer seg7_to_digit(input [6:0] seg);
        case(seg)
            7'b1000000: seg7_to_digit = 0;
            7'b1111001: seg7_to_digit = 1;
            7'b0100100: seg7_to_digit = 2;
            7'b0110000: seg7_to_digit = 3;
            7'b0011001: seg7_to_digit = 4;
            7'b0010010: seg7_to_digit = 5;
            7'b0000010: seg7_to_digit = 6;
            7'b1111000: seg7_to_digit = 7;
            7'b0000000: seg7_to_digit = 8;
            7'b0010000: seg7_to_digit = 9;
				7'b0111111: seg7_to_digit = -2;
            default:    seg7_to_digit = -1;
        endcase
    endfunction
	 
    // ------------------------------------------------------------
    // TASK PER STAMPARE: distance_bin, distance_dec, BCD digits
    // ------------------------------------------------------------
    task print_values;
        integer d0, d1, d2, d3;
    begin
        // estrazione cifre (decodifica segmenti)
        d0 = seg7_to_digit(HEX0);
        d1 = seg7_to_digit(HEX1);
        d2 = seg7_to_digit(HEX2);
        d3 = seg7_to_digit(HEX3);

        $display("Distance (binary):  %b", dut.SYNTHESIZED_WIRE_12);
        $display("Distance (decimal): %0d", dut.SYNTHESIZED_WIRE_12);

        $display("BCD digits: %0d %0d %0d %0d", d3, d2, d1, d0);
        $display("-------------------------------");
    end
    endtask


    // ----------------------------
    // Stimulus process
    // ----------------------------
    initial begin

        $display("----- Starting Simulation -----");

        // Reset
        SW = 0;     // reset active
        #200;
        SW = 1;
        #500;

        // ----------------------------
        // FIRST MEASUREMENT
        // Simulated distance ~ 125 cm → scaled pulse
        // ----------------------------
        $display("Sending echo pulse: 125 us");
        send_echo(350);
        #300000; // wait 300 us
		  print_values();

        // ----------------------------
        // SECOND MEASUREMENT (~50 cm)
        // shorter pulse
        // ----------------------------
        $display("Sending echo pulse: 40 us");
        send_echo(600);
        #300000;
		  print_values();

        // ----------------------------
        // THIRD MEASUREMENT (~250 cm)
        // long pulse
        // ----------------------------
        $display("Sending echo pulse: 250 us");
        send_echo(290);
        #500000;
		  print_values();

        // END SIM
        $display("---- END OF SIMULATION ----");
        #10000;
        $stop;
    end

endmodule
