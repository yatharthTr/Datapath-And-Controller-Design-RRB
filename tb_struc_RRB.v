`include "Struc_rrbfinal.v"
module test;
parameter width=32,channels=8;
parameter clock_period=20;
reg clk,reset;
reg [channels*width-1:0] weight_test;
reg [channels-1:0]request_test;
wire [channels-1:0] grant_test;
// $display("%")
reg [width-1:0]tempData;
integer j=0;
struc_rrb s0(
    .reset(reset),
    .clk(clk),
    .request(request_test),
    .weight(weight_test),
    .grant(grant_test)

);

// initial begin
//     clk=1'b0;
//     reset=1'b1;
//     request_test=0;
//     //tempData=3;
//     weight_test=0;
//     weight_test={32'h00000016,32'h0000000f,32'h0000000f,32'h0000000f,32'h0000000f,32'h0000000f,32'h0000000f,32'h00000004};
initial begin
    clk=1'b0;
    reset=1'b1;
    request_test=0;
    weight_test=32'd3;
    tempData=32'd3;
    
    for(j=1;j<channels;j=j+1)
    begin
        tempData=tempData+2;
        weight_test=weight_test | (tempData<< width*j);
    end
    
    @(posedge clk);
    @(posedge clk);
    reset=1'b0;


    @(posedge clk);
    request_test='b00001000;
    #110
    @(posedge clk);
    request_test='b00000010;
    // weight_test={32'h00000016,32'h0000000f,32'h0000000f,32'h0000000f,32'h0000000f,32'h0000000f,32'h00000002,32'h00000004};
    @(posedge clk);

    #50
    @(posedge clk);
    request_test='b10010001;
    // weight_test={32'h00000016,32'h0000000f,32'h0000000f,32'h0000000f,32'h0000000f,32'h0000000f,32'h0000000f,32'h0000000f};
    @(posedge clk);
    #500
    $finish;
end
initial begin
    $dumpfile("op_of_rrb_nw_016.vcd");
    $dumpvars(0,test);
    $monitor("Time: %0t | Reset: %b | Request: %b |  Grant: %b | Weight: %h", 
            $time, reset, request_test, grant_test, weight_test);
end
always #5
begin
    clk=~clk;
end
endmodule;
