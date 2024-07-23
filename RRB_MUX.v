module MUX(
    reset,
    clk,
    sel_one_hot,
    data_in_bus,
    data_out
);
    parameter channels=8,width=32;
    input reset,clk;
    input [channels-1:0]sel_one_hot;
    input [channels*width-1:0]data_in_bus;
    output reg [width-1:0]data_out;
    //integer  decimal;

    function integer decimal;
        input [channels-1:0] hot_one_code;
        integer i;
        for (i=0;i<channels;i=i+1)
            if(hot_one_code[i])
                decimal=i;
                
    endfunction


    // always @(*)
    // begin
    //     case(sel_one_hot)
    //         8'd1:decimal=0;
    //         8'd2:decimal=1;
    //         8'd4:decimal=2;
    //         8'd8:decimal=3;
    //         8'd16:decimal=4;
    //         8'd32:decimal=5;
    //         8'd64:decimal=6;
    //         8'd128:decimal=7;
    //     endcase;
    // end
            
    //wire [width-1:0]inp_arry=data_in_bus[((decimal[sel_one_hot]+1)*width-1):decimal[sel_one_hot]*width]
    always @(*)
    begin
        data_out=data_in_bus[((decimal(sel_one_hot)+1)*width-1)-:width];
    end



endmodule