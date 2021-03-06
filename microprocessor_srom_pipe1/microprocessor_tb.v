`timescale 1us / 1ns

module microprocessor_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [3:0] i_pins_1, i_pins_2, i_pins_3;

	// Outputs
	wire [3:0] o_reg_1, o_reg_2, o_reg_3;
	wire [7:0] ir_1, pm_data_1, pm_address_1, pc_1, from_PS_1, pm_address_out_1, pm_data_out_1;
	wire [7:0] ir_2, pm_data_2, pm_address_2, pc_2, from_PS_2, pm_address_out_2, pm_data_out_2, pm_data_out_2_2, data_pipe_2;
	wire [7:0] ir_3, pm_data_3, pm_address_3, pc_3, from_PS_3, pm_address_out_3, pm_data_out_3, pm_data_out_2_3, data_pipe_3, address_pipe_3;
	wire flush_pipeline_2, flush_pipeline_3;

	// Instantiate the Unit Under Test (UUT)
	micro_slow_rom m1(
		.clk(clk),
		.reset(reset),
        .i_pins(i_pins_1),
		.ir(ir_1),
		.pc(pc_1),
		.from_PS(from_PS_1),
        .o_reg(o_reg_1),
		.pm_address(pm_address_1),
		.pm_address_out(pm_address_out_1),
		.pm_data(pm_data_1),
		.pm_data_out(pm_data_out_1)
	);

	micro_srom_pipe1 m2(
		.clk(clk),
		.reset(reset),
        .i_pins(i_pins_2),
		.ir(ir_2),
		.pc(pc_2),
		.from_PS(from_PS_2),
        .o_reg(o_reg_2),
		.pm_address(pm_address_2),
		.pm_address_out(pm_address_out_2),
		.pm_data(pm_data_2),
		.pm_data_out(pm_data_out_2),
		.pm_data_out_2(pm_data_out_2_2),
		.data_pipe(data_pipe_2),
		.flush_pipeline(flush_pipeline_2)
	);

	micro_srom_pipe2 m3(
		.clk(clk),
		.reset(reset),
        .i_pins(i_pins_3),
		.ir(ir_3),
		.pc(pc_3),
		.from_PS(from_PS_3),
        .o_reg(o_reg_3),
		.pm_address(pm_address_3),
		.pm_address_out(pm_address_out_3),
		.pm_data(pm_data_3),
		.pm_data_out(pm_data_out_3),
		.pm_data_out_2(pm_data_out_2_3),
		.data_pipe(data_pipe_3),
		.address_pipe(address_pipe_3),
		.flush_pipeline(flush_pipeline_3)
	);

    // length of simulation
    initial #1000 $stop;

    initial
    begin
        clk = 1'b0;
    end

    always
        #0.5 clk = ~clk;

    initial
    begin
        reset = 1'b1;
        #3.2 reset = 1'b0;
        #63 reset = 1'b1;
        #3 reset = 1'b0;
        #91 reset = 1'b1;
        #3 reset = 1'b0;
        #103 reset = 1'b1;
        #101 reset = 1'b0;
    end

	initial begin
        // i_pins stimulus
        i_pins_1 = 4'd5;
        i_pins_2 = 4'd5;
        i_pins_3 = 4'd5;
	end

endmodule
