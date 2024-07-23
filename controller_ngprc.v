module control_ngprc(reset,
clk,
ld_prior,
ld_ng
);
    input reset,clk;
    //input request;
    
    output reg ld_prior,ld_ng;
    reg state,next_state;
    parameter Reset=1'b0,Next_grant=1'b1;
    always @(posedge clk)
    begin
        if (reset) begin
          state<=Reset;
        end
        else begin
        // if(reset);
        // state<=Reset;
        // else 
        // begin
            state<=next_state;
        end
    end
    always @(*)
    begin
        case(state)
            Reset: next_state=reset?Reset:Next_grant;
            Next_grant: next_state=Next_grant;
            default:next_state=state;
        endcase;
    end
    always @(posedge clk)
    begin
        ld_prior<=0;
        ld_ng<=0;
        case(state)
            Reset:begin
                ld_prior<=(reset==0)?1'b1:0;
                ld_ng<=(reset==0)?1'b1:0;
            end
            Next_grant:begin
                ld_prior<=1'b1;
                ld_ng<=1'b1;
            end
        endcase;
    end
endmodule
