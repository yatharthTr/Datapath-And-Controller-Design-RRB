module controller(clk,
grant
,reset
,contrl1
,ld_grant
,ld_weight
,ld_request,ld_count);
    input clk;
    input contrl1;
    input [7:0]grant;
    input reset;
    output reg ld_grant,ld_weight,ld_count,ld_request;
    reg [1:0]state,next_state;
    parameter start=2'b0,granting_process=2'd1,get_weight=2'd2,counting=2'd3;
    // initial begin 
    //     state=start;
    // end
    always @(posedge clk)
    begin
        if(reset) begin
            state<=start;
        end
        else begin
            state<=next_state;
        end    
    end
    always @(*)
    begin
        case (state)
            start:next_state<=granting_process ;
            granting_process:next_state<=(grant!=0)?get_weight:state;
            get_weight:next_state<=counting;
            counting:next_state<=contrl1?granting_process:counting;

            default:next_state<=start; 
        endcase;
    end
    always @(posedge clk)
    begin
        // ld_grant<=state==granting_process || state==get_weight || state==counting;
        ld_grant <= 1'b0;
        ld_weight <= 1'b0;
        ld_count <= 1'b0;
        ld_request <= 1'b1;
        case (state)
            start:ld_grant<=(reset==0)?1'b1:0;
            granting_process:begin
                ld_grant<=1'b1;
                ld_weight<=(grant!=0)?1'b1:0;
            end
            get_weight:begin
                ld_weight<=1'b1;
                ld_count<=1'b1;
            end
            counting:ld_count<=1'b1;
        endcase;
        // ld_grant<=(state==granting_process);
        // // ld_request<=state==granting_process;
        // ld_request<=1'b1;
        // ld_weight<=state==get_weight;
        // ld_count<=state==counting;
    end
    // assign ld_grant=state==granting_process;
    // assign ld_request=1'b1;
    // assign ld_weight=state==get_weight;
    // assign ld_count=state==counting;
endmodule    
