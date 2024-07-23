`include "controller_ngprc.v"
module struc_ngprc(
    clk,
    request,
    reset,
    grant,
    next_grant,
    priorities,
    blk_ng
);
    parameter channels=8;
    input clk;
    input [7:0] request;
    input reset;
    input [7:0]grant;
    output [7:0]priorities;
    output [7:0] next_grant;
    wire ld_prior,ld_ng;
    wire [7:0] blk_priorities;
    output wire [7:0]blk_ng;
    control_ngprc c1(.clk(clk),.ld_ng(ld_ng),.ld_prior(ld_prior),.reset(reset));

    Pipo_nw1 p_0(.clk(clk),.reset(reset),.d(priorities),.q(blk_priorities),.ld(ld_prior));
    //Pipo p_1(.clk(clk),.reset(reset),.d(),.q(blk_priorities),.ld(ld_prior))
    assign priorities=((~{grant[channels-2:0],grant[channels-1]})+1'b1)==0?~0:((~{grant[channels-2:0],grant[channels-1]})+1'b1);

    Pipo_w p_1(.clk(clk),.reset(reset),.d(next_grant),.q(blk_ng),.ld(ld_ng),.request(request));

    // compare_w c0(.a(priorities),.b(8'd0),.out(priorities));
    assign next_grant=request&blk_priorities;

endmodule

    
module Pipo_w(
    clk,
    reset,
    request,
    d,
    q,
    ld
);
    input clk,reset;
    input [7:0]request;
    input [7:0]d;
    input ld;
    output reg [7:0]q;
    always @(posedge clk)
    begin
        if(reset)
        q<=0;
        else
        begin
            if(ld) begin
                if(d==0 && request!=0)
                begin
                    q<=request;
                end
                else begin
                    q<=d;
                end
            end
            else
            q<=q;
        end
    end
endmodule

module Pipo_nw1(
    clk,
    reset,
    d,
    q,
    ld
);
    input clk,reset;
    input [7:0]d;
    input ld;
    output reg [7:0]q;
    always @(posedge clk)
    begin
        if(reset)
        q<=~0;
        else
        begin
            if(ld)
            q<=d;
            else
            q<=q;
        end
    end
endmodule

module compare_w(
    a,
    b,
    out
);
    input [7:0]a,b;
    output [7:0]out;
    assign out=(a==b)?~0:a;
endmodule;



