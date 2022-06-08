`default_nettype none

module sar_10b(
`ifdef USE_POWER_PINS
    input dvdd,
    input dvss,
    input avdd,
    input avss,
`endif
    input vinp,
    input vinn,

    input clk,
    input en,
    input cal,
    input rstn,
    
    output valid,
    output result0,
    output result1,
    output result2,
    output result3,
    output result4,
    output result5,
    output result6,
    output result7,
    output result8,
    output result9,
);

assign result0 = (en) ? 1'b1 : 1'bx;
assign result1 = (en) ? 1'b0 : 1'bx;
assign result2 = (en) ? 1'b1 : 1'bx;
assign result3 = (en) ? 1'b0 : 1'bx;
assign result4 = (en) ? 1'b1 : 1'bx;
assign result5 = (en) ? 1'b0 : 1'bx;
assign result6 = (en) ? 1'b1 : 1'bx;
assign result7 = (en) ? 1'b0 : 1'bx;
assign result8 = (en) ? 1'b1 : 1'bx;
assign result9 = (en) ? 1'b0 : 1'bx;


endmodule
`default_nettype wire
