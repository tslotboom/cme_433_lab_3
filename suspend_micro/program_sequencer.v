module program_sequencer(
input clk, sync_reset, jmp, jmp_nz, dont_jmp,
input [3:0] jmp_addr,
output reg [7:0] pm_addr,

output reg hold_out,

output reg [7:0] pc,
output reg [7:0] from_PS

);

reg start_hold;
reg end_hold;
reg hold;
reg [4:0] hold_count;

always @ *
	if (pc[7:5] != pm_addr[7:5])
		start_hold = 1'b1;
	else
		start_hold = 1'b0;

always @ (posedge clk)
 	if (start_hold || hold)
		hold_count = hold_count + 1'b1;
	else
		hold_count = 5'b0;

always @ *
	if ((hold_count == 31) && (hold == 1'b1))
		end_hold = 1'b1;
	else
		end_hold = 1'b0;

always @ (posedge clk)
	if (sync_reset)
		hold = 1'b0;
	else if (start_hold)
		hold = 1'b1;
	else if (end_hold)
		hold = 1'b0;
	else
		hold = hold;

always @ *
	if ((start_hold == 1'b1 || hold == 1'b1) && !end_hold)
		hold_out = 1'b1;
	else
		hold_out = 1'b0;



// ***from_PS***
always @ *
	// from_PS = 8'h00;
	// from_PS = pc;
	from_PS = hold_count;

// program counter

// reg [7:0] pc;

always @ (posedge clk)
	// if (hold == 1'b1)
	// 	pc = pc;
	// else
		pc = pm_addr;


// logic

always @ (*)
if (sync_reset)
	pm_addr = 8'H00;
else if (hold == 1'b1)
	pm_addr = pc;
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
