include "proyecto_final.v";

module finalpy_testbench_4; //Factorial

reg[4*8:0] str_op;
reg clk;
wire[31:0] resultado;
wire overflow;

datapath test(clk, resultado, overflow);

always #10 clk = ~clk;
initial
  begin
    clk = 0;
#2620 $finish; //131 clock cycles
  end

initial
	$monitor($time, " Clock= %h Resultado = 0x%h Overflow = %h", 
		 clk, resultado, overflow );
endmodule