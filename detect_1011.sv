module detect_1011(
    input        clk,
    input        rst_n,
    input        x,
    output logic y
);
    enum logic [1:0] {
        S0    =   2'b00,
        S1    =   2'b01,
        S10   =   2'b10,
        S101  =   2'b11
    } current_state, next_state;
    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always_comb begin
        case (current_state)
            S0:   next_state = x ? S1   : S0;
            S1:   next_state = x ? S1   : S10;
            S10:  next_state = x ? S101 : S0;
            S101: next_state = x ? S1   : S10;
            default: next_state = S0;
        endcase
    end

    always_comb begin
        y = 0;
        case (current_state)
            S101: y = x ? 1 : 0;
            default: y = 0;
        endcase
    end
endmodule
