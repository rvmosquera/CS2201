//Extender el signo
module extendsign(in, out);

input in;
output out;

wire[15:0] in;
reg[31:0] out;
reg[15:0] bits;

initial
  begin
    bits = 16'hffff;
    out  = 32'h00000000;
  end

  always @(in)
    begin
      out = 32'h00000000;
      out[15:0] <= in;
      if (in[15] == 0)
         out[31:16] <= out[31:16] & bits;
      else
         out[31:16] <= out[31:16] | bits;
    end

endmodule

module test_exten;

reg[15:0] inA;
wire[31:0] outB;

extendsign test(inA, outB);

initial
  begin
//	SB Operation
	inA = 16'h0abc; 
#10	inA = 16'hffff;
#10	inA = 16'h8fff; 
#10	inA = 16'h01ab;
#10	inA = 16'h8bcd;  
  end

initial
	$monitor($time, " Input = %h Resultado = 0x%h", 
		inA, outB );

endmodule