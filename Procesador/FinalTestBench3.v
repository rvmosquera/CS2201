include "proyecto_final.v";

module finalpj_testbench_3;

reg[4*8:0] str_op;
reg clk;
wire[31:0] resultado;
wire overflow;

datapath test3(clk, resultado, overflow);

initial
  begin
//	ADD
	str_op = "ADD";
	clk = 1'b0;
#10	begin
//	BEQ
	str_op = "BEQ";
	clk = 1'b1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	ADDI
	str_op = "ADDI"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	BNEQ
	str_op = "BNEQ";
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	SUBi
	str_op = "SUBi";
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	BGEZ
	str_op = "BGEZ";
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	ADDi
	str_op = "ADDi"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	ADDi
	str_op = "ADDi"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
	clk = 1;
//	ADDi
	str_op = "ADDi"; 
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	JUMP
	str_op = "JUMP"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	SUBI
	str_op = "SUBI"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	JR
	str_op = "JAL"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	ADDI
	str_op = "ADDI"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	JR
	str_op = "JR"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
//	ADDI
#10	begin
	str_op = "ADDI"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	JUMP
	str_op = "JR"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	ADDI
	str_op = "ADDI"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	ADDI
	str_op = ""; 
	clk = 1;
	end
  end

initial
	$monitor($time, " Operation = %s Clock= %h Resultado = 0x%h Overflow = %h", 
		str_op, clk, resultado, overflow );
endmodule