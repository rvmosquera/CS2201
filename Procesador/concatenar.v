module concatena(inA, inB, outC);

input inA;
input inB;
output outC;

wire[31:0] inA;
wire[31:0] inB;
reg[31:0] outC;
reg[31:0] aux;

initial
  begin
    outC = 32'h00000000;
    aux = 32'h00000000;
  end

always @(inA or inB)
  begin
    aux <= 32'h00000000;
    aux = inA[31:28] << 28;
    outC <= aux + inB[27:0];
  end

endmodule

module test_concatena;

reg[31:0] in1;
reg[31:0] in2;
wire[31:0] out3;

concatena four_28(in1, in2, out3);

initial
  begin
    in1 = 32'habc0620B;
    in2 = 32'hfff9fcB0;
#10 begin
      in1 = 32'hfff9fcB0;
      in2 = 32'habc0620B;
    end
  end
 
initial
	$monitor($time, "Input 1= %h Input 2= %h Output 1 = %h", 
			in1, in2, out3);

endmodule