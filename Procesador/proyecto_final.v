//-----------------------------------------------------
// Design Name : datapath
// File Name   : proyecto_final.v
// Function    : Datapath
// Coder       : Raúl Mosquera Pumaricra
//-----------------------------------------------------
include "regfile_lab5.v";
include "alu_lab5.v";
include "extendbit_lab5.v";
include "alucontrol.v";
include "Select_word_half.v";
include "shift_left_2.v";
include "shift16_module.v";
include "instrumem.v";
include "ControlDataPath.v";
include "mux31.v";
include "mux_5bits.v";
include "pccounter_4.v";
include "PC_module.v";
include "concatenar.v";
include "adder32.v";
include "complete_32bits.v";

module datapath(clk, result, overflowout);

input clk;
output overflowout;
output result;

wire[31:0] instruction;
wire clk;
wire overflow;
wire[31:0] ALUresult;
wire[31:0] shiftResult;
wire[31:0] readData1;
wire[31:0] readData2;
wire[31:0] extendout;
wire[31:0] readDataMem;
wire[31:0] out2aux;
wire[31:0] writeData;
wire[31:0] writeDataAux;
wire[31:0] writeDataToMem;
wire[31:0] readDataFromMem;
wire[3:0] ALUOctr;
wire RegWrite;
wire ALUsrc;
wire MemToReg;
wire MemRead;
wire MemWrite;
wire shift16;
wire Jump;
wire JumpSrc;
wire Branch;
wire[1:0] PCsrc;
wire[1:0] PCsrcAux;
wire[1:0] ALUOp;
wire[5:0] inALU;
wire[4:0] readRegAddr1;
wire[4:0] readRegAddr2;
wire[4:0] writeRegAddr;
wire[4:0] writeRegAddrAux;
wire[4:0] writeRAreg;
wire[31:0] PC_4;
wire[31:0] pc_next;
wire[31:0] pc_jump28;
wire[31:0] label_by2;
wire[31:0] pc_jump;
wire[31:0] pc_jump_aux;
wire[31:0] pc_branch;
wire[31:0] jump_addr;
wire[31:0] pc;
reg overflowout;
reg[31:0] result;
//reg[31:0] pc;

ins_memory instruction_memory(pc[7:0], instruction);

pc_module 	pc_mod(		pc_next,
				clk,
				pc);

pc_plus_4	pc_4(		pc,
				PC_4);

control_datapath control(	instruction,
				readRegAddr1,
				readRegAddr2,
				writeRegAddrAux, //writeRegAddr
				RegWrite,
				ALUsrc,
				MemRead,
				MemWrite,
				MemToReg,
				inALU,
				ALUOp,
				shift16,
				PCsrcAux,
				Jump,
				JumpSrc,
				Branch,
				writeRAreg);
//Mux for JAL (Address for register $ra)
mux5bits	mux_for_jal_addr(writeRAreg,
				writeRegAddrAux,
				writeRegAddr,
				Jump);
//Mux for JAL (Value of PC+4
mux5 		mux_for_jal_reg(PC_4,
				writeDataAux,
				writeData,
				Jump);

//Read from Register File
regfile		read_file(	readRegAddr1, 
				readRegAddr2, 
				writeRegAddr, 
				writeData, 
				clk,
				RegWrite, 
				readData1, 
				readData2);
//Extend Sign
extendsign	sign_extend(	instruction[15:0], 
				extendout);
//Mux for ALU source operand
mux5 		mux_alu_src(	readData2, 
				extendout, 
				out2aux, 
				ALUsrc);

//ALU Control
alucontrol	alucontrol(	ALUOp,
				inALU,
				ALUOctr);
//ALU
alu 		alu(		readData1, 
				out2aux, 
				ALUOctr, 
				ALUresult, 
				overflow,
				Zero);
//Data Memory
sel_word_half_byte writeReg(	readData2,
				inALU,
				writeDataToMem);

data_memory 	data_memory(	ALUresult[7:0], 
				clk, 
				MemRead,
			    	MemWrite, 
				writeDataToMem, //readData2, 
				readDataMem);

sel_word_half_byte readReg(	readDataMem,
				inALU,
				readDataFromMem);

shift_16	shift_16_lui(	ALUresult,
				shift16,
				shiftResult);

mux5		mux_reg_src(	shiftResult, 	 //ALUresult,
				readDataFromMem, //readDataMem,
				writeDataAux,
				MemToReg);

branch_control for_branch(	Branch, 
				instruction[31:26], 
				Zero, 
				PCsrcAux,
				PCsrc);
//Shift left 2 for Branch
shift_left_2	shift2Branch(	extendout,
				label_by2);

adder 		add_label(	pc, 
				label_by2, 
				pc_branch);

//Complete 32 bits
complete26_32 for_ins25_0(	instruction[25:0],
				jump_addr);

//Shift left 2 for Jump
shift_left_2	shift2Jump(	jump_addr, //instruction[25:0],
				pc_jump28);

concatena	four_28(	PC_4,
				pc_jump28,
				pc_jump_aux); //pc_jump);

//Jump from register?
mux5		mux_jump_scr(   pc_jump_aux, //pc_jump28,
				ALUresult,
				pc_jump,
				JumpSrc);

/*concatena	four_28(	PC_4,
				pc_jump28,
				pc_jump);*/

mux32_31	muxaddr(	pc_jump, 	//01 (x1)
				pc_branch,	//10
				PC_4,		//00
				PCsrc,
				pc_next);

//Returning values
//always @(instruction)
always @(writeDataToMem or writeData or pc_next)
 begin
  case (instruction[31:26])
//  R-Type
    6'b000000: begin
		 case (instruction[5:0])	//Jump Register
		   6'h08:   result <= pc_next; //assign result = writeData;
		   default: result <= writeData;
		 endcase
		 overflowout = overflow;
	       end
//  J-Type
    6'b000010,6'b000011: 	//Jump, Jump and Link
	       begin
	         result = pc_next;  
	       end
//  I-Type
    default: begin
		 case (instruction[31:26])
		   6'h28: begin	//SB
			    result = writeDataToMem;
			  end
		   6'h29: begin	//SH
			    result = writeDataToMem;
			  end
		   6'h2b: begin	//SW
			    result = writeDataToMem;
			  end
		   6'h24: begin	//LB
			    result = writeData;
			  end
		   6'h25: begin	//LH
			    result = writeData;
			  end
		   6'h23: begin	//LW
			    result = writeData;
			  end
		   6'h0F: begin	//LUI
			    result = writeData;
			  end
		   6'h04, 6'h05, 6'h01: begin //BEQ,BNEQ,BGEZ
					  result = pc_next;
					end
		   default: begin
			      result = writeData;
			    end
		 endcase
		 overflowout = overflow;
	     end
  endcase
//  assign pc = pc_out;
 end

endmodule