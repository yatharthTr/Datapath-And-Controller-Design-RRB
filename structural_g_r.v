`include "controller_g_r.v"
module datapath_g_r(
    request,
    next_grant,
    clk,
    reset,
    grant,
    weight,
    contrl1,
    blk_request,
    // ld_grant,ld_count,ld_request,ld_weight
);
    input [7:0]request;
    input  clk,reset;
    input [7:0] next_grant;
    output wire [7:0] grant;
    //input [32*8-1:0]weight;
    input wire [31:0] weight;
    wire [31:0] blk_weight,s_count;
    // wire [7:0] data_grant;
    wire [7:0] data_grant;
    wire [7:0] t1,t2,t3;
    output wire [7:0] blk_request;
    output wire contrl1;
    wire [31:0]max_weight=32'hf;
    // input wire ld_grant,ld_count,ld_request,ld_weight;//was not there before
// jkkakdhfe

    controller c1(.contrl1(contrl1),.ld_grant(ld_grant),.ld_count(ld_count),.ld_request(ld_request),.ld_weight(ld_weight),.reset(reset),.grant(grant),.clk(clk));
    Pipo p_1(.clk(clk),.d(data_grant),.reset(reset),.Q(grant),.ld(ld_grant));
    Cntr c_1(.clk(clk),.out(s_count),.ld(ld_count),.reset(reset));
    // always @(posedge clk) begin
    //     data_grant<=blk_request&next_grant&(~next_grant+1'b1);
    // end
    // assign data_grant=(next_grant==0 && request!=0)?blk_request&(~blk_request+1'b1):blk_request&next_grant&(~next_grant+1'b1);
    assign data_grant=blk_request&next_grant&(~next_grant+1'b1);
    Pipo_nw p_2(.clk(clk),.d(weight),.ld(ld_weight),.Q(blk_weight),.reset(reset));
    //Pipo p_3(.clk(clk),.d(),ld_weight,.q(blk_weight));
    Pipo p_3(.clk(clk),.d(request),.ld(ld_request),.Q(blk_request),.reset(reset));
    compare c_0(.A(s_count),.B(blk_weight),.max(max_weight),.out(contrl1),.ld(ld_count),.clk(clk));
endmodule

module Pipo(clk,
d,
reset,
Q,
ld
);
    input [7:0]d;
    input reset;
    output  reg [7:0] Q;
    input  clk;
    input ld;
    always @(posedge clk)
    begin
      if(reset)
      Q<=0;
      else
      begin
        if(ld)
        begin
            Q<=d;
        end
        else
        Q<=Q;
      end
    end
endmodule
module Pipo_nw(clk,
d,
reset,
Q,
ld
);
    input [31:0]d;
    input reset;
    output  reg [31:0] Q;
    input  clk;
    input ld;
    always @(posedge clk)
    begin
      if(reset)
      Q<=0;
      else
      begin
        if(ld)
        begin
            Q<=d;
        end
        else
        Q<=Q;
      end
    end
endmodule
module Cntr(clk,
out,
ld,
reset
);
    input clk;
    input ld;
    input reset;
    output reg [31:0] out;
    initial out<=32'd2; 
    always @(posedge clk)
    begin
        // out=16'd2;
        if(reset)
        begin
            out<=32'd2;
        end
        else
        begin
            if(ld)
            out<=out+1;
            else
            out<=32'd2;
        end
    end
endmodule

module adder(
    a,
    b,
    out
);
    input [7:0] a,b;
    output [7:0] out;
    assign out=a+b;
endmodule

module compare(
    clk,
    A,
    B,
    max,
    out,
    ld
);
    input  [31:0]A,B;
    input  [31:0]max;
    input ld,clk;
    // output reg out;
    output wire out;
    // always @(posedge clk) begin
    //     if(ld) begin
    //         out<=(A>=B || A>=max)?1'b1:0;
    //     end
    //     else 
    //     out<=0;
    // end
    assign out = ld?((A>=(B) || A>=max)?1'b1:0):0;
    // assign out =(A>=B || A>=max)?1'b1:0;
endmodule