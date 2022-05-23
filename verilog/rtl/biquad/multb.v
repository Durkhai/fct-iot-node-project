/* ********************************************************************************* */
/*                      multiplier place holder                                      */
/*                                                                                   */
/*  Author:  Chuck Cox (chuck100@home.com)                                           */
/*                                                                                   */
/*                                                                                   */
/*                                                                                   */
/* ********************************************************************************* */


module multb
	(
	clk,			/* clock */
	nreset,			/* active low reset */
	a,			/* data input */
	b,			/* input data valid */
	r			/* filter pole coefficient */
	);

parameter	DATAWIDTH = 16;
parameter	COEFWIDTH = 16;

input 					clk;
input 					nreset;
input	[COEFWIDTH-2:0]			a;
input	[DATAWIDTH-2:0]			b;
output	[DATAWIDTH + COEFWIDTH - 3:0]	r;


assign r = a*b;


endmodule
