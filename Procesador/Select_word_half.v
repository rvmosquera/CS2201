module sel_word_half_byte(inA, func, outA);
input inA;
input func;
output outA;

wire[31:0] inA;
wire[5:0] func;
reg[31:0] outA;

always @(inA or func)
  begin
    outA <= 32'h00000000;
    case (func)
      6'h28, 6'h24: begin	//SB LB
  	       outA[7:0] <= inA[7:0];
	     end
      6'h29, 6'h25: begin	//SH LH
	       outA[15:0] <= inA[15:0];
	     end
      6'h2b, 6'h23: begin	//SW LW
	       outA <= inA;
	     end
/*      6'h24: begin	//LB
	       outA[7:0] <= inA[7:0];
	     end
      6'h25: begin	//LH
	       outA[15:0] <= inA[15:0];
	     end
      6'h23: begin 	//LW
	       outA <= inA;
	     end */
/*      6'h0F: begin 	//LUI
	       outA[31:16] = inA[15:0];
	     end */
    endcase
  end

endmodule

module test_word_half;

reg[31:0] inA;
reg[5:0] func;
wire[31:0] outA;

sel_word_half_byte test(inA, func, outA);

initial
  begin
    func = 6'h28;
    inA = 32'h0000620B;
//    inB = 32'h00007CD9;  
#10 begin
    func = 6'h29;
    inA = 32'h0000C117;
//    inB = 32'hFFFF8189;
    end
#10 begin
    func = 6'h2b;
    inA = 32'hFFFF8189;
//    inB = 32'h0F00C117;
    end
#10 begin
    func = 6'h24;
    inA = 32'h00007CD9;
//    inB = 32'h0000C117;
    end
#10 begin
    func = 6'h25;
    inA = 32'h0A00AF17;
//    inB = 32'hF0F0C117;
    end
#10 begin
    func = 6'h23;
    inA = 32'hFFFF8189;
//    inB = 32'hFFFF8189;
    end
/*#10 begin
    func = 6'h0F;
    inA = 32'h00008189;
//    inB = 32'hFFFF8189;
    end*/
#10 $finish;
  end

initial
	$monitor($time, "Func = %h Input 1= %h Output 1 = %h", 
		func, inA, outA);

endmodule