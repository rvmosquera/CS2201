module adder(inA, inB, outC);

input inA;
input inB;
output outC;

wire[31:0] inA;
wire[31:0] inB;
wire[31:0] outC;

assign outC = inA + inB;

endmodule

module testbench_adder;

reg[31:0] in1;
reg[31:0] in2;
wire[31:0] out3;

adder test(in1, in2, out3);

initial
  begin
    in1 = 32'hf0f0fabc;
    in2 = 32'h0000fa24;
#10 in1 = 32'hffff0000;
#10 in2 = 32'h0b0b0b0b;
#10 $finish;
  end

initial
	$monitor($time, "Entrada 1= %h Entrada 2 = %h resultado = %h", 
		in1, in2, out3);

endmodule