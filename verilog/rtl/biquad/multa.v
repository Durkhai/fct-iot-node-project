/* ********************************************************************************* */
/*                      multiplier place holder                                      */
/*                                                                                   */
/*  Author:  Chuck Cox (chuck100@home.com)                                           */
/*                                                                                   */
/*                                                                                   */
/*                                                                                   */
/* ********************************************************************************* */


module multa #(
	parameter	DATAWIDTH = 16,
	parameter	COEFWIDTH = 16 
)
	(
	input	[COEFWIDTH-2:0]		a,			/* data input */
	input	[DATAWIDTH+2:0]		b,			/* input data valid */
	output	[DATAWIDTH + COEFWIDTH + 1:0]	p			/* filter pole coefficient */
	);

assign p = a*b;

endmodule
