module shift_left_2(inA, outA);

input inA;
output outA;

wire[31:0] inA;
reg[31:0] outA;

always @(inA)
  begin
    outA <= inA << 2;
  end

endmodule


module test_shiftl2;

reg[31:0] inA;
wire[31:0] outA;

shift_left_2 shiftl2(inA, outA);

initial
  begin
    inA = 32'h0000620B;
#10 begin
      inA = 32'h0F00C117;
    end
  end

initial
	$monitor($time, "Input 1= %h Output 1 = %h", 
			inA, outA);

endmodule