/* ********************************************************************************* */
/*										     */
/*        		Main module for biquad filter			             */
/*                                                                                   */
/*  Author:  Chuck Cox (chuck100@home.com)                                           */
/*                                                                                   */
/* This filter core uses a wishbone interface for compatibility with other cores:    */
/*										     */
/* Wishbone general description:  16x5 register file				     */
/* Supported cycles:  Slave Read/write, block read/write, RMW			     */
/* Data port size:  16 bit							     */
/* Data port granularity: 16 bit						     */
/* Data port maximum operand size:  16 bit					     */
/*                                                                                   */
/*      Addr	register							     */
/*      ----    --------							     */
/*	0x0	Filter coefficient a11						     */
/*	0x1	Filter coefficient a12						     */
/*  0x2	Filter coefficient b10						     */
/*	0x3	Filter coefficient b11						     */
/*	0x4	Filter coefficient b12						     */
/*                                                                                   */
/*  Filter coefficients need to be written as 16 bit twos complement fractional	     */
/*  numbers.  For example:  0100_0000_0000_0001 = 2^-1 + 2^-15 = .500030517578125    */
/*										     */
/*  The equation for the filter implemented with this core is                        */
/*  y[n] = b10 * x[n] + b11 * x[n-1] + b12 * x[n-2] + a11 * y[n-1] + a12 * y[n-2]    */
/* 										     */
/*  This biquad filter is parameterized.  If a filter with coefficients less than    */
/*  16 bits in length is selected via parameters then the most significant bits of   */
/*  the value written to the filter coefficient register shall be used (ie	     */
/*  coefficients shall be truncated as required by parameter value COEFWIDTH).	     */
/*										     */
/*  See comments in biquad module for more details on filtering algorthm.	     */
/* ********************************************************************************* */





module bqmain #(
	parameter	DATAWIDTH = 16,
	parameter	COEFWIDTH = 16
	)
	(
    `ifdef USE_POWER_PINS
		inout vccd1,
		inout vssd1,
    `endif 
	input	wb_clk_i,		/* Wishbone clk */
	input	wb_rst_i,		/* Wishbone asynchronous active high reset */
	input	wb_we_i,		/* Wishbone write enable */
	input	wb_stb_i,		/* Wishbone strobe */
	output	wb_ack_o,		/* Wishbone ack */
	input	[31:0]	wb_dat_i,		/* Wishbone input data */
	output	[31:0]	wb_dat_o,		/* Wishbone output data */
	input	[31:0]	wb_adr_i,		/* Wishbone address bus */
	input	bq_clk_i,
	input	valid_i,		
	input	nreset,		/* active low asynchronous reset for filter block */
	input	[DATAWIDTH-1:0]	x,
	output	wire [DATAWIDTH-1:0]	y,
	input	wb_cyc_i
	);
	

wire	[31:0]	a11;
wire	[31:0]	a12;
wire	[31:0]	b10;
wire	[31:0]	b11;
wire	[31:0]	b12;


/* Filter module */
biquad biquadi
	(
	.clk(bq_clk_i),				/* clock */
	.nreset(nreset),			/* active low reset */
	.x(x),						/* data input */
	.valid(valid_i),				/* input data valid */
	.a11(a11[COEFWIDTH-1:0]),		/* filter pole coefficient */
	.a12(a12[COEFWIDTH-1:0]),		/* filter pole coefficient */
	.b10(b10[COEFWIDTH-1:0]),		/* filter zero coefficient */
	.b11(b11[COEFWIDTH-1:0]),		/* filter zero coefficient */
	.b12(b12[COEFWIDTH-1:0]),		/* filter zero coefficient */
	.yout(y)					/* filter output */
	);

/* Wishbone interface module */
coefio coefioi
	(
	.clk_i(wb_clk_i),
	.rst_i(wb_rst_i),
	.we_i(wb_we_i),	
	.stb_i(wb_stb_i),
	.cyc_i(wb_cyc_i),
	.ack_o(wb_ack_o),
	.dat_i(wb_dat_i[31:0]),
	.dat_o(wb_dat_o[31:0]),
	.adr_i(wb_adr_i[31:0]),
	.a11(a11),
	.a12(a12),
	.b10(b10),
	.b11(b11),
	.b12(b12),
	.x(x),
	.y(y)
	);

endmodule
