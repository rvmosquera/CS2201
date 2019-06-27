module pc_module(inPC, clk, outPC);

input inPC;
input clk;
output outPC;

wire[31:0] inPC;
reg[31:0] outPC;

initial
  outPC = 32'h00000000;

always @(posedge clk)
  outPC <= inPC;


endmodule