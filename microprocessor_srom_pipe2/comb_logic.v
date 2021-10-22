module comb_logic(
    input [7:0] in,
    output reg [7:0] out
    );

    reg [63:0] mid_computation;

    always @ * begin
        mid_computation = in * 64'h05;
        mid_computation = mid_computation + 64'h03;
		  mid_computation = mid_computation << 64'h1;
		  mid_computation = mid_computation * 64'h3;
		  mid_computation = mid_computation / 64'h6;
        mid_computation = mid_computation - 64'h01;
        mid_computation = mid_computation - 64'h02;
        mid_computation = mid_computation / 64'h05;
        out = mid_computation;
    end

endmodule
