`timescale 1us / 1ns

module microprocessor_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [3:0] i_pins;

	// Outputs
	wire [3:0] o_reg;

	wire [7:0] ir, pm_address, pc, from_PS;

	// Instantiate the Unit Under Test (UUT)
	CME341_latest_microprocessor uut (
		.clk(clk),
		.reset(reset),
        .i_pins(i_pins),
		.ir(ir),
		.pc(pc),
		.pm_address(pm_address),
		.from_PS(from_PS),
        .o_reg(o_reg)
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
        i_pins = 4'd5;
	end

endmodule