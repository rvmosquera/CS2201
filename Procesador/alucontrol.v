module alucontrol(aluOp, func, out);

input func;
input aluOp;
output out;
wire[5:0] func;
wire[1:0] aluOp;
reg[3:0] out;

initial
 out = 4'h0;

always @(func or aluOp)
 begin
   case (aluOp)
     2'b00: //R type
	case (func)
	  6'h24: out <= 4'b0000; //AND
	  6'h25: out <= 4'b0001; //OR
	  6'h20: out <= 4'b0010; //ADD
	  6'h22: out <= 4'b0110; //SUB
	  6'h2A: out <= 4'b0111; //SLT
	  6'h27: out <= 4'b1100; //NOR
	  6'h3F: out <= 4'b1111; //mult
	  6'h08: out <= 4'b0010; //ADD for JR
	endcase  
     2'b01: //I Type
	case (func)
	  6'h08: out <= 4'b0010; //ADD
	  6'h0b: out <= 4'b0110; //SUB
	  6'h0c: out <= 4'b0000; //AND
	  6'h0d: out <= 4'b0001; //OR
	  6'h0a: out <= 4'b0111; //SLT
	  6'h04,6'h05: out = 4'b0110; // SUB for BEQ, BNEQ
	  6'h01: out <= 4'b0111; // SLT for BGEZ
	  default: out <= 4'b0010; //ADD
	endcase
     //2'b10:
     //2'b11:
   endcase
 end

endmodule

module test_alucont;

reg[5:0] inA;
reg[1:0] aluopIn;
reg[4*8:0] str_op;
wire[3:0] outB;

alucontrol alucon(aluopIn, inA, outB);

initial
  begin
    str_op = "ADDi";
    aluopIn = 2'b01;
    inA = 6'h08;
#10 begin inA = 6'h0b;
	  str_op = "SUBi";
    end
#10 begin inA = 6'h0c;
	  str_op = "ANDi";
    end
#10 begin inA = 6'h0d;
	  str_op = "ORi";
    end
#10 begin inA = 6'h0a;
	  str_op = "SLTi";
    end
#10 begin inA = 6'h24;
    	  aluopIn = 2'b00;
	  str_op = "AND";
    end
#10 begin inA = 6'h25;
	  str_op = "OR";
    end
#10 begin inA = 6'h20;
	  str_op = "ADD";
    end
#10 begin inA = 6'h22;
	  str_op = "SUB";
    end
#10 begin inA = 6'h2a;
	  str_op = "SLT";
    end
#10 begin inA = 6'h27;
	  str_op = "NOR";
    end
#10 begin inA = 6'h28;
    	  aluopIn = 2'b01;
	  str_op = "SB";
    end
#10 begin inA = 6'h29;
	  str_op = "SH";
    end
#10 begin inA = 6'h2B;
	  str_op = "SW";
    end
#10 begin inA = 6'h24;
	  str_op = "LB";
    end
#10 begin inA = 6'h25;
	  str_op = "LH";
    end
#10 begin inA = 6'h23;
	  str_op = "LW";
    end
  end

initial
	$monitor($time, "Operation = %s In = %h Alu = %b", str_op, inA, outB);

endmodule