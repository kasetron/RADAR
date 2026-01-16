module echo (
	input clk,   // 50MHz
	input rst_l,
	input echo,
	output reg en_sr,  // enable per shift register filtro mediano
	output wire [11:0] distance
); // carpisce durata livello alto dell'echo


// Definizione stati: S0: idle, S1: start ranging count, S2: end ranging count
reg[1:0] curr_state, next_state;
localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
localparam MAXCOUNT = 20'd441428;

reg echo_reg1, echo_reg2;  // reg1 è echo campionato e reg2 è reg1 ritardato di un ciclo di clk
wire start, finish;

assign start = echo_reg1&~echo_reg2;  //Detect posedge
assign finish = ~echo_reg1&echo_reg2; //Detect negedge
reg[19:0] count = 0;
reg[19:0] dis_reg = 0;

always @ (posedge clk) begin

	if(~rst_l) begin
	
		echo_reg1 <= 1'b0;
		echo_reg2 <= 1'b0;
		count <= 1'b0;
		dis_reg <= 1'b0;
		curr_state <= S0;
		en_sr <= 1'b0;
		
	end else begin
	
		echo_reg1 <= echo;      // current
		echo_reg2 <= echo_reg1; // next
		
		case(curr_state)
			S0:begin
				en_sr <= 1'b0;
				if (start) // detected rising edge
					curr_state <= next_state; //S1
				else
					count <= 1'b0;
            end
			S1:begin
				if (finish || count == MAXCOUNT) begin // detected falling edge o massimo
					curr_state <= next_state; //S2
				end else count <= count + 1;
				end
			S2:begin
				dis_reg <= count; // memorizza conteggio
				en_sr <= 1'b1;
				count <= 1'b0;
				curr_state <= next_state; //S0
            end
			default: curr_state <= S0;
		endcase
	end
end

always @ (curr_state) begin
	case(curr_state)
		S0:next_state <= S1;
		S1:next_state <= S2;
		S2:next_state <= S0;
		default: next_state <= S0; // recovery
	endcase
end

assign distance = (dis_reg*226) >> 16; // (*20/(50*58)=0.00345 troncato in modo da avere err<1mm) distanza in mm

endmodule
