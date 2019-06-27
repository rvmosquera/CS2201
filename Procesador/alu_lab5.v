module alu(inA, inB, control, outC, overflow,outZero);

input inA;
input inB;
input control;
output outC;
output outZero;
output overflow;

wire[31:0] inA, inB;
reg[32:0] aux;
reg[31:0] outC;
reg overflow;
reg outZero;
wire[3:0] control;

//always@(*)	    //D-RMP 22/11/2018 13:57	 
always@(inA or inB or control) //I-RMP 22/11/2018 13:57
  begin 
   overflow <= 1'b0;
   aux <= 33'h000000000;
   case (control)
     4'b0000 : outC <= inA & inB;
     4'b0001 : outC <= inA | inB;
     4'b0010 : begin aux = inA + inB; overflow <= aux[32]; outC <= aux[31:0]; end
     4'b0110 : outC <= inA - inB;
     4'b0111 : outC <= (inA<inB)?1:0;
     4'b1100 : outC <= ~( inA | inB);
     4'b1111 : outC <= inA * inB; //to multiply
   endcase
  end

always @(outC)
  begin
    if (outC == 32'h00000000)
      outZero = 1'b1;
    else
      outZero = 0'b0;
  end

endmodule
//Testbench ALU
module testbench_alu;

reg[31:0] entrada1, entrada2;
reg[3:0] control;
wire[31:0] salida;
wire overflow;
wire zero;

alu alu_test(entrada1, entrada2, control, salida, overflow, zero);

initial
  begin
    entrada1 = 32'hffff0000;
    entrada2 = 32'hffffffff;
    control = 4'b0000; //and
#10 entrada1 = 32'hffff0000;
#10 entrada2 = 32'h0000ffff;
#10 control = 4'b0001; //or
#10 begin entrada1 = 32'hffffffff; entrada2 = 32'hffffffff; control = 4'b0010; end //add
#10 begin entrada1 = 32'hffffffff; entrada2 = 32'h0000ff00; control = 4'b0110; end //sub
#10 begin control = 4'b0111; entrada1 = 32'h0000ffff; entrada2 = 32'hffffffff; end //slt
#10 begin control = 4'b1100; entrada1 = 32'h0101ffff; entrada2 = 32'h00000101; end //nor
#10 begin control = 4'b1111; entrada1 = 32'h0000000f; entrada2 = 32'h00000003; end //mult
#10 $finish;
  end

initial
	$monitor($time, "Control = %h , in1= %h in2 = %h resultado = %h overflow = %h Zero = %h", 
		control, entrada1, entrada2, salida, overflow, zero);

endmodule