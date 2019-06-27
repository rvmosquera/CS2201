//-----------------------------------------------------
// Design Name : ins_memory
// File Name   : instrumem.v
// Function    : Instruction Memory
// Coder       : Raúl Mosquera Pumaricra
//-----------------------------------------------------
module ins_memory(pcIn, insOut);

input pcIn;
output insOut;

reg[7:0] instructions[255:0];
reg[31:0] insOut;
wire[7:0] pcIn;

initial
 begin
//  $readmemh("instructionstest1.txt", instructions); //First Test bench
//  $readmemh("instructionstest2.txt", instructions); //Second Test bench
//  $readmemh("instructionstest3.txt", instructions); //Third Test bench
//   $readmemh("instructions_multi.txt", instructions); //Multiplication method (2*3)
  $readmemh("factorial.txt",instructions); //Factorial function (n=10) 
 end 

always @(pcIn)
 begin
   insOut[31:24] <= instructions[pcIn];
   insOut[23:16] <= instructions[pcIn+1];
   insOut[15:8] <= instructions[pcIn+2];
   insOut[7:0] <= instructions[pcIn+3];
 end

endmodule

module test_im;
reg[7:0] pc;
wire[31:0] instruc;

ins_memory im(pc, instruc);

initial
  begin
    #10 begin
	 pc = 8'h00;
	end
    #10 begin
	 pc = 8'h04;
	end
    #10 begin
	 pc = 5'h08;
	end
    #10 begin
	 pc = 8'h0c;
	end
    #10 begin
	 pc = 8'h10;
	end
    #10 begin
	 pc = 8'h14;
	end
    #10 begin
	 pc = 8'h18;
	end
    #10 begin
	 pc = 8'h1c;
	end
    #10 begin
	 pc = 8'h20;
	end
    #10 begin
	 pc = 8'h24;
	end
    #10 begin
	 pc = 8'h28;
	end
    #10 begin
	 pc = 8'h2c;
	end
    #10 begin
	 pc = 8'h30;
	end
    #10 begin
	 pc = 8'h34;
	end
    #10 begin
	 pc = 8'h38;
	end
    #10 begin
	 pc = 8'h40;
	end
  end

initial
	$monitor($time,"PC = %h Instruction = %h", pc, instruc);

endmodule