// Alisha Chulani achulani@g.hmc.edu
// Sep 4, 2024
// This projet will test that LEDs on the board are working properly by lighting up under simple and and xor gates
// It also includes code for a 7-segment display based on the same switches

module top(
     input   logic reset,
	 input	 logic [3:0] switch,
     output  logic [2:0] led,
	 output  logic [6:0] segs
); 

   logic int_osc;
   
  
   // changed this to low frequency oscillator - 10kHz
   LSOSC #() 
         lf_osc (.CLKLFPU(1'b1), .CLKLFEN(1'b1), .CLKLF(int_osc));

	led_gates testing_leds(int_osc, reset, switch, led);
	sevenseg power_sevenseg(switch, segs); 

endmodule 


// module for testing the LEDs by flashing one, XOR the other, and AND the last one  
module led_gates(
	input clk, reset,
	input logic [3:0] switch,
	output logic [2:0 led,
	);
		      
  
   // Counter
logic [11:0] counter;
always_ff @(posedge clk) begin
     if(reset == 0)  counter <= 0;
     else            counter <= counter + 1;
   end
  
   // Assign LED output
   assign led[2] = counter[11];
   assign led[0] = switch[0] ^ switch[1];
   assign led[1] = switch[2] & switch[3];

endmodule
		

// module for powering the seven segment display 
module sevenseg( input logic [3:0] switch,
		output logic [6:0] segs
		);
   
   // Logic for 7-segment display 
   always_comb begin
	  case(switch)
			4'b0000: segs = 7'b0000001;
			4'b0001: segs = 7'b1001111;
			4'b0010: segs = 7'b0010010;
			4'b0011: segs = 7'b0000110;
			4'b0100: segs = 7'b1001100;
			4'b0101: segs = 7'b0100100;
			4'b0110: segs = 7'b0100000;
			4'b0111: segs = 7'b0001111;
			4'b1000: segs = 7'b0000000;
			4'b1001: segs = 7'b0000100;
			4'b1010: segs = 7'b0001000;
			4'b1011: segs = 7'b1100000;
			4'b1100: segs = 7'b0110001;
			4'b1101: segs = 7'b1000010;
			4'b1110: segs = 7'b0110000;
			4'b1111: segs = 7'b0111000;
	   endcase
	 end 
endmodule 
	 
	
