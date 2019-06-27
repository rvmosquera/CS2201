//-----------------------------------------------------
// Design Name : control_datapath
// File Name   : ControlDataPath.v
// Function    : Control the instructions of the Datapath
// Coder       : Raúl Mosquera Pumaricra
//-----------------------------------------------------
module control_datapath(
inInstru,
outReadRegA1, 
outReadRegA2,
outWriteRegA, 	
outRF, 		//Register File
outALUsrc,
outMemRead,	//Read from Data Memory
outMemWrite,	//Write to Data Memory
outMemToReg,
outfuncALU,	//ALU function for ALU control
outALUOp,	//ALU operation for ALU control
outshift16,
outPCsrc,	//Program Counter Source
outJump,	//Jump
outJumpSrc,	//Jump from reg?
outBranch,	//Branch
outWriteRAreg);

input inInstru;
output outReadRegA1;
output outReadRegA2;
output outWriteRegA;
output outRF; //Register File Write
output outALUsrc; 
output outMemRead;
output outMemWrite;
output outMemToReg;
output outfuncALU;
output outALUOp;
output outshift16;
output outPCsrc;
output outJump;
output outJumpSrc;
output outBranch;
output outWriteRAreg;

wire[31:0] inInstru;
reg[4:0] outReadRegA1;
reg[4:0] outReadRegA2;
reg[4:0] outWriteRegA;
reg[4:0] outWriteRAreg;
reg outRF;
reg outALUsrc;
reg outMemRead;
reg outMemWrite;
reg outMemToReg;
reg[5:0] outfuncALU;
reg[1:0] outALUOp;
reg outshift16;
reg[1:0] outPCsrc;
reg outJump;
reg outJumpSrc;
reg outBranch;

initial
  begin
    outRF = 1'b0;
    outALUsrc = 1'b0;
    outMemRead = 1'b0;
    outMemWrite = 1'b0;
    outMemToReg = 1'b0;
    outfuncALU = 6'h00;
    outALUOp = 2'b00;
    outshift16 = 1'b0;
    outPCsrc = 2'b00;
    outJump = 1'b0;
    outJumpSrc = 1'b1;
    outBranch = 1'b0;
    outWriteRAreg = 5'b11111;
  end

always @(inInstru)
  begin
    case (inInstru[31:26])
//  R-Type
    6'b000000: begin
		 outReadRegA1 <= inInstru[25:21];
		 outReadRegA2 <= inInstru[20:16];
		 outWriteRegA <= inInstru[15:11];
		 outALUsrc <= 1'b1;
		 outMemRead <= 1'b0;
		 outMemWrite <= 1'b0;
		 outMemToReg <= 1'b1;
    		 outJump <= 1'b0;
		 outBranch <= 1'b0;
		 outfuncALU <= inInstru[5:0];
		 outALUOp <= 2'b00;
	 	 outshift16 <= 1'b0;
		 //outRF = 1'b1; //Write to Register File RMP-22/11/2018 18:15
		 case (inInstru[5:0])	//Jump Register
		   6'h08: begin
		            outPCsrc <= 2'b01;
		 	    outRF <= 1'b0; //Write to Register File
			    outJumpSrc <= 1'b0;
			  end
		   default: begin 
			      outRF <= 1'b1; //Write to Register File RMP-22/11/2018 18:15
		              outPCsrc <= 2'b00;
			    end
	  	 endcase
	       end
//  J-Type
    6'b000010,6'b000011: 
	       begin
    		 outPCsrc <= 2'b01;
    		 outJump <= 1'b1;
		 outBranch <= 1'b0;
		 case (inInstru[31:26])
		   6'h02: begin //Jump
		 	    outRF <= 1'b0; //no Write to Register File
		 	    outJumpSrc <= 1'b1;
			  end
		   6'h03: begin //Jump and link
		 	    outRF <= 1'b1; //Write to Register File
		 	    outJumpSrc <= 1'b1;
			  end
	         endcase
               end
//  I-Type
    default: begin
		 outReadRegA1 <= inInstru[25:21];
		 outWriteRegA <= inInstru[20:16];
		 outfuncALU <= inInstru[31:26];
		 outALUOp <= 2'b01;
		 outshift16 <= 1'b0;
		 outPCsrc <= 2'b00;
		 outJumpSrc <= 1'b1;
		 outBranch <= 1'b0;
    		 outJump <= 1'b0;
		 outALUsrc <= 1'b0;
		 case (inInstru[31:26])
		   6'h04, 6'h05: 
			  begin	//BEQ, BNEQ
    			    outReadRegA2 <= inInstru[20:16];
			    outBranch <= 1'b1;
		 	    outALUsrc <= 1'b1;
			    outRF <= 1'b0; //no Write to Register File
			  end
		   6'h01: begin //BGEZ
			    outReadRegA2 <= inInstru[20:16];
    			    outBranch <= 1'b1;
			    outALUsrc <= 1'b0;
			    outRF <= 1'b0; //no Write to Register File
 			  end
		   6'h28: begin	//SB
		 	    outReadRegA2 <= inInstru[20:16];
			    outMemToReg <= 1'b1;
		            outMemRead  <= 1'b0;
			    outMemWrite <= 1'b1;
		 	    outRF <= 1'b0; //no Write to Register File
			  end
		   6'h29: begin	//SH
		 	    outReadRegA2 <= inInstru[20:16];
			    outMemToReg <= 1'b1;
		            outMemRead  <= 1'b0;
			    outMemWrite <= 1'b1;
		 	    outRF <= 1'b0; //no Write to Register File
			  end
		   6'h2b: begin	//SW
		 	    outReadRegA2 <= inInstru[20:16];
			    outMemToReg <= 1'b1;
		            outMemRead  <= 1'b0;
			    outMemWrite <= 1'b1;
		 	    outRF <= 1'b0; //no Write to Register File
			  end
		   6'h24: begin	//LB
		 	    outReadRegA2 <= inInstru[20:16];
			    outMemToReg <= 1'b0;
		            outMemRead  <= 1'b1;
			    outMemWrite <= 1'b0;
		 	    outRF <= 1'b1; //Write to Register File
			  end
		   6'h25: begin	//LH
		 	    outReadRegA2 <= inInstru[20:16];
			    outMemToReg <= 1'b0;
		            outMemRead  <= 1'b1;
			    outMemWrite <= 1'b0;
		 	    outRF <= 1'b1; //Write to Register File
			  end
		   6'h23: begin	//LW
		 	    outReadRegA2 <= inInstru[20:16];
			    outMemToReg <= 1'b0;
		            outMemRead  <= 1'b1;
			    outMemWrite <= 1'b0;
		 	    outRF <= 1'b1; //Write to Register File
			  end
		   6'h0F: begin	//LUI
		 	    outReadRegA2 <= inInstru[25:21];
			    outMemRead <= 1'b0;
			    outMemWrite <= 1'b0;
			    outMemToReg <= 1'b1;
			    outshift16 <= 1'b1;
		 	    outRF <= 1'b1; //Write to Register File
			  end
		   default: begin
			      outMemToReg <= 1'b1;
			      outMemRead <= 1'b0;
			      outMemWrite <= 1'b0;
		 	      outReadRegA2 <= inInstru[25:21];
		 	      outRF <= 1'b1; //Write to Register File
			    end
		 endcase
	     end
  endcase
end

endmodule