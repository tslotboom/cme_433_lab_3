module program_sequencer(
input clk, sync_reset, jmp, jmp_nz, dont_jmp,
input [3:0] jmp_addr,
output reg [7:0] pm_addr,

output reg [7:0] pc,
output reg [7:0] from_PS);

// ***from_PS***
always @ *
//from_PS = 8'h00;
from_PS = pc;


// program counter

// reg [7:0] pc;

always @ (posedge clk)
	pc = pm_addr;


// logic

always @ (*)
if (sync_reset)
	pm_addr = 8'H00;
else if (jmp)
	pm_addr = {jmp_addr, 4'H0};
else if (jmp_nz)
	if (dont_jmp == 0)
		pm_addr = {jmp_addr, 4'H0};
	else
		pm_addr = pc + 8'H01;
else
	pm_addr = pc + 8'H01;
endmodule
