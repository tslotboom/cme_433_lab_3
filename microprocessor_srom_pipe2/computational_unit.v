module computational_unit(
input clk, sync_reset, i_sel, y_sel, x_sel,
input [3:0] i_pins, dm, nibble_ir, source_sel,
input [8:0] reg_en,
output reg r_eq_0,
output reg [3:0] i, data_bus, o_reg,

output reg [7:0] from_CU,
output reg [3:0] x0, x1, y0, y1, r, m);

//reg [3:0] x0;
//reg [3:0] x1;
//reg [3:0] y0;
//reg [3:0] y1;
//reg [3:0] r;
//reg [3:0] m;

always @ *
//from_CU = 8'h00;
from_CU = {x1,x0};
//from_CU = {3'h0, i_sel, 3'h0, reg_en[6]};

// ***data_bus and source_sel logic***
always @ *
case(source_sel)
4'b0000: data_bus = x0;
4'b0001: data_bus = x1;
4'b0010: data_bus = y0;
4'b0011: data_bus = y1;
4'b0100: data_bus = r;
4'b0101: data_bus = m;
4'b0110: data_bus = i;
4'b0111: data_bus = dm;
4'b1000: data_bus = nibble_ir;
4'b1001: data_bus = i_pins;
4'b1010: data_bus = 4'h0;
4'b1011: data_bus = 4'h0;
4'b1100: data_bus = 4'h0;
4'b1101: data_bus = 4'h0;
4'b1110: data_bus = 4'h0;
4'b1111: data_bus = 4'h0;
default: data_bus = 4'h0;
endcase


//***x0 register***
always @ (posedge clk)
if (reg_en[0] == 1'b1)
	x0 = data_bus;
else
	x0 = x0;

//***x1 register***
always @ (posedge clk)
if (reg_en[1] == 1'b1)
	x1 = data_bus;
else
	x1 = x1;

//***y0 register***
always @ (posedge clk)
if (reg_en[2] == 1'b1)
	y0 = data_bus;
else
	y0 = y0;

//***y1 register***
always @ (posedge clk)
if (reg_en[3] == 1'b1)
	y1 = data_bus;
else
	y1 = y1;





//***m register***
always @ (posedge clk)
if (reg_en[5])
	m = data_bus;
else
	m = m;

//***i register***
always @ (posedge clk)
if (reg_en[6] == 1'b1)
	if (i_sel == 0)
		i = data_bus;
	else
		i = i + m;
else
	i = i;

//***o_reg***
always @ (posedge clk)
if (reg_en[8] == 1'b1)
	o_reg = data_bus;
else
	o_reg = o_reg;


//***ALU***
reg [3:0] x;
reg [3:0] y;

reg alu_out_eq_0;
reg [3:0] alu_out;

// x_sel
always @ *
if (x_sel == 1)
	x = x1;
else
	x = x0;

// y_sel
always @ *
if (y_sel == 1)
	y = y1;
else
	y = y0;

// alu_out - r
reg [7:0] mult_result;
always @ *
mult_result = x*y;


always @ (posedge clk)
if (sync_reset)
	r = 4'h0;
else if (reg_en[4])
	case(nibble_ir[2:0]) // ALU function
	3'b000:
		if (nibble_ir[3] == 1'b0)
			r = -x;
		else // NOP D8, C8
			r = r;
	3'b001: r = x - y;
	3'b010: r = x + y;
	3'b011: r = mult_result[7:4];
	3'b100: r = mult_result[3:0];
	3'b101: r = x ^ y;
	3'b110: r = x & y;
	3'b111:
		if (nibble_ir[3] == 1'b0)
			r = ~x;
		else // NOP DF, CF
			r = r;
	default: r = r;
	endcase
else
	r = r;

// alu_out_eq_0 - r_eq_0 - zero_flag
always @ (*)
if (sync_reset)
	r_eq_0 = 1'b1;
else if (r == 1'b0)
	r_eq_0 = 1'b1;
else
	r_eq_0 = 1'b0;

	
	
	
	
	
	
//// alu_out_eq_0 - r_eq_0 - zero_flag
//always @ (*)
//if (sync_reset)
//	r_eq_0 = 1'b1;
//else if (reg_en[4])
//	else if (r == 1'b0)
//		r_eq_0 = 1'b1;
//	else
//		r_eq_0 = 1'b0;
//else 
//	r_eq_0 = r_eq_0;

	
////***zero_flag register***
//always @ (posedge clk)
//if (reg_en[4] == 1'b1)
//	r_eq_0 = alu_out_eq_0;
//else
//	r_eq_0 = r_eq_0;
//
////***r reg***
//always @ (posedge clk)
//if (reg_en[4] == 1'b1)
//	r = alu_out;
//else
//	r = r;
	
	
	
//	
//	
//always @ (posedge clk)
//if (sync_reset)
//	alu_out = 4'h0;
//else
//	case(nibble_ir[2:0]) // ALU function
//	3'b000:
//		if (nibble_ir[3] == 1'b0)
//			alu_out = -x;
//		else // NOP D8, C8
//			alu_out = alu_out;
//	3'b001: alu_out = x - y;
//	3'b010: alu_out = x + y;
//	3'b011: alu_out = mult_result[7:4];
//	3'b100: alu_out = mult_result[3:0];
//	3'b101: alu_out = x^y;
//	3'b110: alu_out = x & y;
//	3'b111:
//		if (nibble_ir[3] == 1'b0)
//			alu_out = ~x;
//		else // NOP DF, CF
//			alu_out = alu_out;
//	default: alu_out = alu_out;
//	endcase
//
//// alu_out_eq_0 - r_eq_0 - zero_flag
//always @ (posedge clk)
//if (sync_reset)
//	alu_out_eq_0 = 1'b1;
//else if (alu_out == 1'b0)
//	alu_out_eq_0 = 1'b1;
//else
//	alu_out_eq_0 = 1'b0;
//
//	
////***zero_flag register***
//always @ (*)
//if (reg_en[4] == 1'b1)
//	r_eq_0 = alu_out_eq_0;
//else
//	r_eq_0 = r_eq_0;
//
////***r reg***
//always @ (*)
//if (reg_en[4] == 1'b1)
//	r = alu_out;
//else
//	r = r;
	
endmodule
