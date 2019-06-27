//-----------------------------------------------------
// Design Name : regfile
// File Name   : regfile_lab5.v
// Function    : Store the MIPS 32 registers
// Coder       : Raúl Mosquera Pumaricra
//-----------------------------------------------------
module regfile(in1, in2, in3, wreg, clk, sel, out1, out2);
input in1;
input in2;
input in3;
input clk;
input wreg;
input sel;
output out1;
output out2;

wire sel;
wire [4:0] in1, in2, in3;
wire [31:0] wreg;
wire [31:0] out1, out2;
reg[31:0] memory[31:0];

initial
 begin
  $readmemb("registerstest1.txt", memory);
 end 

   assign out1 = (in1 == 5'h00 ) ? 32'h00000000 : memory[in1];
   assign out2 = (in2 == 5'h00 ) ? 32'h00000000 : memory[in2];

always @(posedge clk)
 begin
   if (sel == 1'b1) //write
     begin
	memory[in3] <= wreg;
     end
 end

endmodule

module testbench_reg;
reg[4:0] entrada1, entrada2, entrada3;
reg reloj;
reg[31:0] reges;
reg selec;
wire[31:0] salida1, salida2;

regfile regfile_test(entrada1, entrada2, entrada3, reges, reloj, selec, salida1, salida2);

initial
  begin
    entrada1=5'b00000;entrada2=5'b00000;entrada3=5'b00000;
    reges=32'h00000000;
    reloj = 0;
#10 begin reloj=1; selec=1; entrada3=5'b10001; reges = 32'hffff0000; end
#10 begin reloj=0; selec=1; entrada3=5'b10011; reges = 32'h0000ffff; end
#10 begin reloj=1; end
#10 begin reloj=0; end
#10 begin reloj=1; selec=0; entrada1=5'b10011; entrada2=5'b10001; end
#10 begin reloj=0; end
#10 begin reloj=1; end
#10 begin reloj=0; end
#10 begin reloj=1; end
  end

initial
	$monitor($time, "clock= %h In1= %h In2 = %h In3 = %h Sali1 = %h Sali2 = %h", reloj, entrada1, entrada2, entrada3,
		salida1, salida2 );

endmodule