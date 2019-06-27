include "proyecto_final.v";

module finalpy_testbench_1;

reg[4*8:0] str_op;
reg clk;
wire[31:0] resultado;
wire overflow;

datapath test(clk, resultado, overflow);

initial
  begin
//	ADD Operation
	str_op = "ADD";
	clk = 1'b0;
#10	begin
//	SUB Operation
	str_op = "SUB";
	clk = 1'b1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	AND Operation
	str_op = "AND";
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	NOR Operation 
	str_op = "NOR";
	clk = 1;
	end
#10	begin 
	clk = 0;
	end
#10	begin
//	OR Operation
	str_op = "OR";
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	SLT Operation
	str_op = "SLT"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	ADDi Operation
	str_op = "ADDi"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	SUBi Operation
	str_op = "SUBi"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	ANDi Operation
	str_op = "ANDi"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	ORi Operation
	str_op = "ORi"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	SLTi Operation
	str_op = "SLTi"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
	clk = 1;
	end
  end

initial
//	$monitor($time, " Operation = %s PC = %h Clock= %h \nInstruction= 0x%h Resultado = 0x%h Overflow = %h", 
//		str_op, pc, clk, instruccion, resultado, overflow );
	$monitor($time, " Operation = %s Clock= %h Resultado = 0x%h Overflow = %h", 
		str_op, clk, resultado, overflow );
endmodule