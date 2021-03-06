module instruction_decoder(
input clk, sync_reset,
input [7:0] next_instr,
output reg jmp, jmp_nz,
output reg [3:0] ir_nibble,
output reg i_sel, y_sel, x_sel,
output reg [3:0] source_sel,
output reg [8:0] reg_en,

output reg [7:0] ir,
output reg [7:0] from_ID,
output reg NOPC8, NOPCF, NOPD8, NOPDF
);

// reg [7:0] ir;

always @ *
if (ir == 8'hC8)
	NOPC8 = 1'b1;
else
	NOPC8 = 1'b0;

always @ *
if (ir == 8'hCF)
	NOPCF = 1'b1;
else
	NOPCF = 1'b0;

always @ *
if (ir == 8'hD8)
	NOPD8 = 1'b1;
else
	NOPD8 = 1'b0;

always @ *
if (ir == 8'hDF)
	NOPDF = 1'b1;
else
	NOPDF = 1'b0;




localparam LOAD = 1'b0; 		// ir[7]
localparam MOV = 2'b10; 		// ir[7:6]
localparam ALU = 3'b110; 		// ir[7:5]
localparam JUMP = 4'b1110; 	// ir[7:4]
localparam CJUMP = 4'b1111;	// ir[7:4]

localparam X0 = 3'b000;
localparam X1 = 3'b001;
localparam Y0 = 3'b010;
localparam Y1 = 3'b011;
localparam R =  3'b100; // also o_reg
localparam M =  3'b101;
localparam I =  3'b110;
localparam DM = 3'b111;

localparam PM_DATA = 4'd8;
localparam I_PINS = 4'd9;


// ***from_ID***
always @ *
//from_ID = 8'H00;
from_ID = reg_en[7:0];
//from_ID = {7'b0000000, i_sel};

// ***instruction register***
always @ (posedge clk)
ir = next_instr;


// ***reg en***
// enable registers to be written to - IE enable registers as desinations

// x0
always @ *
if (sync_reset)
	reg_en[0] = 1'b1;
else if (ir[7] == LOAD && ir[6:4] == X0) // load instr
	reg_en[0] = 1'b1;
else if (ir[7:6] == MOV && ir[5:3] == X0) // mov instr
	reg_en[0] = 1'b1;
else
	reg_en[0] = 1'b0;

// x1
always @ *
if (sync_reset)
	reg_en[1] = 1'b1;
else if (ir[7] == LOAD && ir[6:4] == X1) // load instr
	reg_en[1] = 1'b1;
else if (ir[7:6] == MOV && ir[5:3] == X1) // mov instr
	reg_en[1] = 1'b1;
else
	reg_en[1] = 1'b0;

// y0
always @ *
if (sync_reset)
	reg_en[2] = 1'b1;
else if (ir[7] == LOAD && ir[6:4] == Y0) // load instr
	reg_en[2] = 1'b1;
else if (ir[7:6] == MOV && ir[5:3] == Y0) // mov instr
	reg_en[2] = 1'b1;
else
	reg_en[2] = 1'b0;

// y1
always @ *
if (sync_reset)
	reg_en[3] = 1'b1;
else if (ir[7] == LOAD && ir[6:4] == Y1) // load instr
	reg_en[3] = 1'b1;
else if (ir[7:6] == MOV && ir[5:3] == Y1) // mov instr
	reg_en[3] = 1'b1;
else
	reg_en[3] = 1'b0;

// r reg
always @ *
if (sync_reset)
	reg_en[4] = 1'b1;
else if (ir[7:5] == ALU) // ALU instr
	reg_en[4] = 1'b1;
else
	reg_en[4] = 1'b0;

// o_reg
always @ *
if (sync_reset)
	reg_en[8] = 1'b1;
else if (ir[7] == LOAD && ir[6:4] == R) // load instr
	reg_en[8] = 1'b1;
else if (ir[7:6] == MOV && ir[5:3] == R) // mov instr
	reg_en[8] = 1'b1;
else
	reg_en[8] = 1'b0;

// m
always @ *
if (sync_reset)
	reg_en[5] = 1'b1;
else if (ir[7] == LOAD && ir[6:4] == M) // load instr
	reg_en[5] = 1'b1;
else if (ir[7:6] == MOV && ir[5:3] == M) // mov instr
	reg_en[5] = 1'b1;
else
	reg_en[5] = 1'b0;

// i
always @ *
if (sync_reset)
	reg_en[6] = 1'b1;
else if ((ir[7] == LOAD) && (ir[6:4] == I)) // load instr
	reg_en[6] = 1'b1;
else if ((ir[7:6] == MOV) && (ir[5:3] == I)) // mov instr
	reg_en[6] = 1'b1;
else if ((ir[7] == LOAD) && (ir[6:4] == DM)) // load dm
	reg_en[6] = 1'b1;
else if ((ir[7:6] == MOV) && (ir[5:3] == DM)) // mov, dm = dest
	reg_en[6] = 1'b1;
else if ((ir[7:6] == MOV) && (ir[2:0] == DM) && (ir[5:3] != I)) // mov, dm = source, destination reg is not i (ir[5:3] != I)
	reg_en[6] = 1'b1;
else
	reg_en[6] = 1'b0;

// dm
always @ *
if (sync_reset)
	reg_en[7] = 1'b1;
else if (ir[7] == LOAD && ir[6:4] == DM) // load instr
	reg_en[7] = 1'b1;
else if (ir[7:6] == MOV && ir[5:3] == DM) // mov instr
	reg_en[7] = 1'b1;
else
	reg_en[7] = 1'b0;


// ***source_sel***
// select a register to be a source
always @ *
if (sync_reset)
	source_sel = 4'd10;
else if (ir[7] == 1'b0) // load instr
	source_sel = PM_DATA;
else if ((ir[7:6] == MOV) && (ir[5:3] == R) && (ir[2:0] == R)) // mov isntr, dest == dource == r
	source_sel = 4'd4; // move to or_reg
else if ((ir[7:6] == MOV) && (ir[5:3] == ir[2:0]) && (ir[5:3] != R))
// mov instr, dest == source, dest does not equal 4'h4 (o_reg)
	source_sel = I_PINS;
else if (ir[7:6] == MOV) // mov instr
	source_sel = {1'b0, ir[2:0]};
else
	source_sel = 4'd10;


//***i, x, y selects***

// i sel
always @ *
if (sync_reset)
	i_sel = 1'b0;
else if (ir[7] == LOAD && ir[6:4] == DM) // load dm
	i_sel = 1'b1;
else if ((ir[7:6] == MOV) && (ir[5:3] == DM)) // mov, dm = dest
	i_sel = 1'b1;
else if ((ir[7:6] == MOV) && (ir[2:0] == DM) && (ir[5:3] != I)) // mov, dm = source - destination reg should not be i (ir[5:3] != I)
	i_sel = 1'b1;
else
	i_sel = 1'b0;

//// i sel
//always @ *
//if (sync_reset)
//	i_sel = 1'b0;
//else if ((ir[7] == LOAD) && (ir[6:4] == I)) // load to I
//	i_sel = 1'b0;
//else if ((ir[7:6] == MOV) && (ir[5:3] == I)) // move to I
//	i_sel = 1'b0;
//else
//	i_sel = 1'b1;

// x sel
always @ *
if (sync_reset)
	x_sel = 1'b0;
else if (ir[7:5] == ALU)
	x_sel = ir[4];
else
	x_sel = 1'b0;

// y sel
always @ *
if (sync_reset)
	y_sel = 1'b0;
else if (ir[7:5] == ALU)
	y_sel = ir[3];
else
	y_sel = 1'b0;


//***jump and conditional jump**
// jump
always @ *
if (sync_reset)
	jmp = 1'b0;
else if (ir[7:4] == JUMP)
	jmp = 1'b1;
else
	jmp = 1'b0;


// jump_nz
always @ *
if (sync_reset)
	jmp_nz = 1'b0;
else if (ir[7:4] == CJUMP)
	jmp_nz = 1'b1;
else
	jmp_nz = 1'b0;


// ***ir_nibble***
always @ *
ir_nibble = ir[3:0];

endmodule
