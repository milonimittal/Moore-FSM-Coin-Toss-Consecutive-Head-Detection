module Sequence_Detector_MOORE_Verilog(sequence_in,clock,reset,detector_out);
input clock; // clock signal
input reset; // reset input
input sequence_in; // binary input
output reg detector_out; // output of the sequence detector
parameter  Zero=4'b0001, // "Zero" State
  One=4'b0010, // "One" State
  Two=4'b0100, // "OneZero" State
  Three=4'b1000; // "OnceZeroOne" State
reg [3:0] current_state, next_state; // current state and next state
// sequential memory of the Moore FSM
always @(posedge clock, posedge reset)
begin
 if(reset==1) 
 current_state <= Zero;// when reset=1, reset the state of the FSM to "Zero" State
 else
 current_state <= next_state; // otherwise, next state
end 
// combinational logic of the Moore FSM to determine next state 
always @(current_state,sequence_in)
begin
 case(current_state) 
 Zero:begin
  if(sequence_in==1)
   next_state <= One;
  else
   next_state <= Zero;
 end
 One:begin
  if(sequence_in==1)
   next_state <= Two;
  else
   next_state <= Zero;
 end
 Two:begin
  if(sequence_in==1)
   next_state <= Three;
  else
   next_state <= Zero;
 end 
 Three:begin
  if(sequence_in==1)
   next_state <= Three;
  else
   next_state <= Zero;
 end
 default:next_state <= Zero;
 endcase
end
// combinational logic to determine the output of the Moore FSM, output only depends on current state
always @(current_state)
begin 
 case(current_state) 
 Zero:   detector_out <= 0;
 One:   detector_out <= 0;
Two:  detector_out <= 0;
Three:  detector_out <= 1;
 default:  detector_out <= 0;
 endcase
end 
endmodule

`timescale 1ns / 1ps

module tb_Sequence_Detector_Moore_FSM_Verilog;

 // Inputs
 reg sequence_in;
 reg clock;
 reg reset;

 // Outputs
 wire detector_out;

 // Instantiate the Sequence Detector using Moore FSM
 Sequence_Detector_MOORE_Verilog uut (
  .sequence_in(sequence_in), 
  .clock(clock), 
  .reset(reset), 
  .detector_out(detector_out)
 );
 initial begin
 clock = 0;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;
#5 clock = ~clock;

 end 
 initial begin
  // Initialize Inputs
  sequence_in = 0;
  reset = 1;
  // Wait 100 ns for global reset to finish
  #30;
      reset = 0;
  #40;
  sequence_in = 1;
  #10;
  sequence_in = 0;
  #10;
  sequence_in = 1; 
  #10;
  sequence_in = 1; 
  #10;
  sequence_in = 1; 
  #10;
  sequence_in = 0; 
  #20;
  sequence_in = 1; 
  #20;
  sequence_in = 0;  
  #10;
  sequence_in = 1; 
  #10;
  sequence_in = 1; 
  #10;
  sequence_in = 1; 
  #10;
  sequence_in = 1; 
  #10;
  sequence_in = 0; 
  // Add stimulus here

 end

initial 
    begin
        $dumpfile("test.vcd");
        $dumpvars;
    end

endmodule