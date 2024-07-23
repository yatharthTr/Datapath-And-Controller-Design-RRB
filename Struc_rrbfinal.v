`include "RRB_MUX.v" 
`include "structural_g_r.v"
`include "structure_ngprc.v"
module struc_rrb(
    clk,
    reset,
    request,
    weight,
    grant
);
    parameter channels=8,width =32;
    input clk,reset;
    input [channels-1:0] request;
    input [channels*width-1:0] weight;
    output wire [channels-1:0]grant;

    wire [width-1:0]get_weight;
    wire [channels-1:0] next_grant;
    wire [channels-1:0] priorities;
    wire [7:0]blk_request,blk_ng;
    wire contrl1;
    // wire [7:0] blk_ng;

    MUX m0(
        .reset(reset),
        .clk(clk),
        .sel_one_hot(grant),
        .data_in_bus(weight),
        .data_out(get_weight)
    );

    datapath_g_r d0(.clk(clk),.reset(reset),.next_grant(blk_ng),.grant(grant),.weight(get_weight),.request(request),.blk_request(blk_request),.contrl1(contrl1));
    struc_ngprc s0(.clk(clk),.reset(reset),.request(blk_request),.grant(grant),.next_grant(next_grant),.priorities(priorities),.blk_ng(blk_ng));
endmodule

