
module CORDIC (
	a,
	areset,
	clk,
	x,
	y,
	xo,
	yo);	

	input	[17:0]	a;
	input		areset;
	input		clk;
	input	[16:0]	x;
	input	[16:0]	y;
	output	[17:0]	xo;
	output	[17:0]	yo;
endmodule
