module shift_16(inA, sel, outA);

input inA;
input sel;
output outA;

wire[31:0] inA;
reg[31:0] outA;

always @(inA or sel)
  begin
    if (sel == 1'b1 )
      outA <= inA << 16;
    else if (sel == 1'b0 )
      outA <= inA;
  end

endmodule

module test_shift16;

reg[31:0] inA;
reg sel;
wire[31:0] outA;

shift_16 test(inA, sel, outA);

initial
  begin
    sel = 1'b0;
    inA = 32'h0000620B;
#10 begin
      sel = 1'b1;
      inA = 32'h0000C117;
    end
  end

initial
	$monitor($time, "Func = %h Input 1= %h Output 1 = %h", 
		sel, inA, outA);

endmodule