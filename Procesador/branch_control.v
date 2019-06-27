module branch_control(inBranch, inOp, inZero, inPCsrc, outPCsrc);

input inBranch;
input inZero;
input inPCsrc;
input inOp;
output outPCsrc;

wire inBranch;
wire inZero;
wire[5:0] inOp;
wire[1:0] inPCsrc;
reg[1:0] outPCsrc;

initial
  outPCsrc = 2'b00;

//always @(*)
always @(inBranch or inPCsrc or inOp or inZero) //RMP-22/11/2018 20:53
  begin
    if ( inBranch == 1'b0 )
      begin
	outPCsrc <= inPCsrc;
      end
    else if ( inBranch == 1'b1 )
      begin
	case (inOp)
	  6'h04, 6'h01: //BEQ, BGEZ
	    outPCsrc[1] = inBranch & inZero;
	  6'h05: //BNEQ
	    outPCsrc[1] = inBranch ^ inZero;
	endcase
	outPCsrc[0] = 1'b0;
      end    
  end

endmodule

module test_branch_ctr;

reg branch;
reg[5:0] op;
reg zero;
reg[1:0] inPC;
wire[1:0] outPC;

branch_control test(branch, op, zero, inPC, outPC);

initial
  begin
    branch = 1'b0;
    inPC = 2'b00;
#10 begin
    	  branch = 1'b0;
          inPC = 2'b10;
    end
#10 begin
          inPC = 2'b01;
	  op = 6'h04;
	  zero = 1'b1;
    end
#10 begin
          inPC = 2'b01;
    end
#10 begin
    	  branch = 1'b1;

	  zero = 1'b1;
          inPC = 2'b11;
    end
#10 begin
	  zero = 1'b0;
    end
#10 begin
	  op = 6'h05;
	  zero = 1'b1;
    end
#10 begin
	  op = 6'h05;
	  zero = 1'b0;
    end
#10 begin
	  op = 6'h01;
	  zero = 1'b1;
    end
#10 begin
	  op = 6'h01;
	  zero = 1'b0;
    end
  end

initial
	$monitor($time, "Branch = %h Op = %h Zero = %h inPC = %h outPC = %h", 
			branch, op, zero, inPC, outPC);

endmodule