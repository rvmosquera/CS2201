module mux5(inA, inB, out, select);

input inA;
input inB;
input select;
output out;

wire[31:0] inA, inB;
//reg[31:0] out;
wire[31:0] out;

//always@(*)
//always @(inA or inB or select)
  assign out = (select==1)?inA:inB;

endmodule
//Testbench for mux5
module testbench_mux5;

reg[31:0] entradaA, entradaB;
wire[31:0] salida;
reg sel;

mux5 muxtest(entradaA, entradaB, salida, sel);

initial
  begin
    entradaA = 32'hfafafafa;
    entradaB = 32'h0f0f0f0f;
    sel = 1;
#10 entradaA = 32'h00000000;
#10 sel = 0;
#10 $finish;
  end

initial
	$monitor($time, "Entrada 1= %h Entrada 2 = %h resultado = %h selector = %h", 
		entradaA, entradaB, salida, sel);

endmodule