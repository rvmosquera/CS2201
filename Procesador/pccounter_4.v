module pc_plus_4(inPC, outPC);

input inPC;
output outPC;

wire[31:0] inPC;
wire[31:0] outPC;

assign outPC = inPC + 4;

endmodule