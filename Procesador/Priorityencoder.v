//Laboratorio 1: Ejercicio 3 - Priority Encoder 8 a 3
module priorencoder(in, out);

input in;
output out;

wire[7:0] in;
wire[2:0] out;

assign out[2] = ( ~in[7] & ~in[6] ) & ( in[5] | in[4] ) | in[7] | in[6];

assign out[1] =  ~in[7] & ~in[6] & ~in[5] & ~in[4] & ( in[3] | in[2] ) | in[7] | in[6];

assign out[0] = ( ~in[7] & ~in[6] & ~in[5] & ~in[4] & ~in[3] & ~in[2] & in[1] )
		| ( ~in[7] & ~in[6] & ~in[5] & ~in[4] & in[3] )
		| ( ~in[7] & ~in[6] & in[5] ) | ( in[7] );

endmodule

module test_prior;

reg[7:0] inA;
wire[2:0] outB;

priorencoder prio(inA, outB);

initial
 begin
   #10 begin inA = 8'h01; end 
   #10 begin inA = 8'h02; end 
   #10 begin inA = 8'h04; end 
   #10 begin inA = 8'h08; end 
   #10 begin inA = 8'h10; end
   #10 begin inA = 8'h20; end
   #10 begin inA = 8'h40; end
   #10 begin inA = 8'h80; end   
 end

initial
   $monitor($time,"inA = %b Out = %h", inA, outB);

endmodule