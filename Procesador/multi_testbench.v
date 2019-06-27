include "proyecto_final.v";

module multi_testbench;

reg[4*8:0] str_op;
reg clk;
wire[31:0] resultado;
wire overflow;

datapath test3(clk, resultado, overflow);

initial
  begin
//	ADDi
	str_op = "ADDi";
	clk = 1'b0;
#10	begin
//	ADDi
	str_op = "ADDi";
	clk = 1'b1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	JAL
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
//	ADDI
	str_op = "ADDI";
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
//	SLT
	str_op = "SLT"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	BEQ
	str_op = "BEQ"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
	clk = 1;
//	SUB
	str_op = "SUBI"; 
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
//	ADD
	str_op = "ADD"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	J
	str_op = "J"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	ADD
	str_op = "ADDI"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
	str_op = ""; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
	str_op = ""; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
	str_op = ""; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
	str_op = ""; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
	str_op = ""; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
	str_op = ""; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
	str_op = ""; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
	str_op = ""; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
	str_op = ""; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
	str_op = ""; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
  end

initial
	$monitor($time, " Operation = %s Clock= %h Resultado = 0x%h Overflow = %h", 
		str_op, clk, resultado, overflow );
endmodule