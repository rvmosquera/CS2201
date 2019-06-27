module data_memory(inAddr, clk, inMemRead, inMemWrite, inWriteReg, outReadReg);

input inAddr;
input clk;
input inMemRead;
input inMemWrite;
input inWriteReg;
output outReadReg;

reg[7:0] data[255:0];
reg[31:0] outReadReg;
wire[7:0] inAddr;
wire clk;
wire inMemRead;
wire inMemWrite;
wire[31:0] inWriteReg;

initial
  begin
    $readmemh("datamemorytest2.txt", data);
  end 
/*
always @(posedge clk)
  begin
    if (sel == 1'b0)	
	begin	outReadReg[31:24] = data[inAddr];
		outReadReg[23:16] = data[inAddr+1];
		outReadReg[15:8]  = data[inAddr+2];
		outReadReg[7:0]   = data[inAddr+3];
	end
    else if (sel == 1'b1)	
	begin   data[inAddr]   = inWriteReg[31:24];
		data[inAddr+1] = inWriteReg[23:16];
		data[inAddr+2] = inWriteReg[15:8];
		data[inAddr+3] = inWriteReg[7:0];
	end
  end*/

always @(*)
  begin
    if (inMemRead == 1'b1)
       begin    outReadReg[31:24] = data[inAddr];
		outReadReg[23:16] = data[inAddr+1];
		outReadReg[15:8]  = data[inAddr+2];
		outReadReg[7:0]   = data[inAddr+3];
       end
  end

//always @(negedge clk)
always @(posedge clk)
  begin
/*    if (sel == 1'b0)	
	begin	outReadReg[31:24] = data[inAddr];
		outReadReg[23:16] = data[inAddr+1];
		outReadReg[15:8]  = data[inAddr+2];
		outReadReg[7:0]   = data[inAddr+3];
	end
    else */
    if (inMemWrite == 1'b1)	
	begin   data[inAddr]   = inWriteReg[31:24];
		data[inAddr+1] = inWriteReg[23:16];
		data[inAddr+2] = inWriteReg[15:8];
		data[inAddr+3] = inWriteReg[7:0];
	end
  end

endmodule

module testbench_data;

reg[7:0] inAddr;
reg clock;
reg inMemRead;
reg inMemWrite;
reg[31:0] inReg;
wire[31:0] outReg; 

data_memory data(inAddr, clock, inMemRead, inMemWrite, inReg, outReg);

initial
  begin
    clock = 0;
    inAddr = 8'h00;
    inMemRead = 1'b1;
    inMemWrite = 1'b0;
#10 begin
      clock = 1;
      inMemRead = 1'b1;
      inMemWrite = 1'b0;
    end
#10 begin
      clock = 0;
      inAddr = inAddr + 8'h04;
      inMemRead = 1'b1;
      inMemWrite = 1'b0;
    end
#10 begin
      clock = 1;
      inMemRead = 1'b1;
      inMemWrite = 1'b0;
    end
#10 begin
      clock = 0;
      inAddr = inAddr + 8'h04;
      inMemRead = 1'b1;
      inMemWrite = 1'b0;
    end
#10 begin
      clock = 1;
      inMemRead = 1'b1;
      inMemWrite = 1'b0;
    end
#10 begin
      clock = 0;
      inAddr = inAddr + 8'h04;
      inMemRead = 1'b1;
      inMemWrite = 1'b0;
    end
#10 begin
      clock = 1;
      inMemRead = 1'b1;
      inMemWrite = 1'b0;
    end
#10 begin
      clock = 0;
      inAddr = inAddr + 8'h04;
      inMemRead = 1'b1;
      inMemWrite = 1'b0;
    end
#10 begin
      clock = 1;
      inMemRead = 1'b1;
      inMemWrite = 1'b0;
    end
#10 begin
      clock = 0;
      inAddr = inAddr + 8'h04;
      inMemRead = 1'b1;
      inMemWrite = 1'b0;
    end
#10 begin
      clock = 1;
      inMemRead = 1'b1;
      inMemWrite = 1'b0;
    end
#10 begin
      clock = 0;
      inAddr = inAddr + 8'h04;
      inMemRead = 1'b1;
      inMemWrite = 1'b0;
    end
#10 begin
      clock = 1;
      inMemRead = 1'b0;
      inMemWrite = 1'b1;
      inReg = 32'h1E61;
    end
  end

initial
	$monitor($time, "Clock= %h Read = %h Write = %h Address = %h outReg = %h", clock, inMemRead, 
		inMemWrite, inAddr, outReg);

endmodule