// Top level module MPU
// Thomas Slotboom 11221182

module CME341_latest_microprocessor(
input clk, reset,
input [3:0] i_pins,
output [3:0] o_reg,

output [7:0] pm_data,
output [7:0] pc, from_PS, pm_address,
output [7:0] ir, from_ID,
output [8:0] register_enables,
output NOPC8, NOPCF, NOPD8, NOPDF,
output [7:0] from_CU,
output zero_flag,
output [3:0] x0, x1, y0, y1, r, m, i);

reg sync_reset;
//wire [7:0] pm_address;
wire jump, conditional_jump;
wire [3:0] LS_nibble_ir;
//wire pm_data, i_mux_select, y_reg_select, x_reg_select;
wire i_mux_select, y_reg_select, x_reg_select;
wire [3:0] source_select;
//wire [8:0] register_enables;
//wire [3:0] i, data_bus, dm;
wire [3:0] data_bus, dm;

// wire [3:0] top_nibble;

always @ (posedge clk)
		sync_reset = reset;





program_sequencer prog_sequencer(.clk(clk),
		.sync_reset(sync_reset),
		.pm_addr(pm_address),
		.jmp(jump),
		.jmp_nz(conditional_jump),
		.jmp_addr(LS_nibble_ir),
		.dont_jmp(zero_flag),
		.pc(pc),
		.from_PS(from_PS)
		);

program_memory prog_mem(.clock(~clk),
		.address(pm_address),
		.q(pm_data)
		);

instruction_decoder instr_decoder(.clk(clk),
		.sync_reset(sync_reset),
		.jmp(jump),
		.jmp_nz(conditional_jump),
		.ir_nibble(LS_nibble_ir),
		.i_sel(i_mux_select),
		.y_sel(y_reg_select),
		.x_sel(x_reg_select),
		.source_sel(source_select),
		.reg_en(register_enables),
		.next_instr(pm_data),
		.ir(ir),
		.from_ID(from_ID),
		.NOPC8(NOPC8),
		.NOPCF(NOPCF),
		.NOPD8(NOPD8),
		.NOPDF(NOPDF)
		);

computational_unit comp_unit(.clk(clk),
		.sync_reset(sync_reset),
		.i_sel(i_mux_select),
		.y_sel(y_reg_select),
		.x_sel(x_reg_select),
		.i_pins(i_pins),
		.dm(dm),
		.nibble_ir(LS_nibble_ir),
		.source_sel(source_select),
		.reg_en(register_enables),
		.r_eq_0(zero_flag),
//		.i(data_mem_addr),
		.i(i),
		.data_bus(data_bus),
		.o_reg(o_reg),
		.from_CU(from_CU),
		.x0(x0),
		.x1(x1),
		.y0(y0),
		.y1(y1),
		.r(r),
		.m(m)
		);

data_memory data_mem(.clock(~clk),
		.address(i),
		.data(data_bus),
		.q(dm),
		.wren(register_enables[7])
		);
endmodule