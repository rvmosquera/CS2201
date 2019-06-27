include "proyecto_final.v";

module finalpj_testbench_2;

//wire[31:0] instruccion;
reg[4*8:0] str_op;
reg clk;
wire[31:0] resultado;
wire overflow;
//reg[31:0] pc;

//ins_memory instruction_mem(pc[7:0], instruccion);
//datapath test(instruccion, clk, resultado, overflow);
datapath test(clk, resultado, overflow);

initial
  begin
//	SB Operation
	str_op = "SB";
	clk = 1'b0;
#10	begin
//	SH Operation
	str_op = "SH";
	clk = 1'b1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	SW Operation
	str_op = "SW"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	LB Operation
	str_op = "LB";
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	LH Operation
	str_op = "LH";
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	LW Operation
	str_op = "LW"; 
	clk = 1;
	end
#10	begin 
	clk = 0; 
	end
#10	begin
//	LUI Operation
	str_op = "LUI"; 
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
/*#10	begin 
	clk = 0; 
	pc = pc + 32'h00000004;
	str_op = "SUBi"; 
	end*/
  end

initial
	$monitor($time, " Operation = %s Clock= %h Resultado = 0x%h Overflow = %h", 
		str_op, clk, resultado, overflow );
endmodule