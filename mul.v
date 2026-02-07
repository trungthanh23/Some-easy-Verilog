module mul #(parameter N = 4) (
    input clk,
    input rst_n,
    input [N-1:0] SBN, 
    input [N-1:0] SN,  
    input start,
    output reg [2*N-1:0] result,
    output reg valid
);
    reg [2*N-1:0] a;    
    reg [2*N-1:0] b;    
    reg [N-1:0] count;  
    reg [2*N-1:0] y;    

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            result <= 0;
            valid <= 0;
            a <= 0;
            b <= 0;
            count <= 0;
            y <= 0;
        end
        else begin
            if (start && count == 0) begin
                a <= {{N{1'b0}}, SBN};
                b <= {{N{1'b0}}, SN}; 
                y <= 0;
                count <= 0;
                valid <= 0;
            end
            else if (count < N) begin
                if (b[0]) begin
                    y <= y + (a << count);
                end
                b <= b >> 1;
                count <= count + 1;

                if (count == N-1) begin
                    result <= y + (b[0] ? (a << count) : 0);
                    valid <= 1;
                end
            end
            else begin
                valid <= 0;
            end
        end
    end

endmodule