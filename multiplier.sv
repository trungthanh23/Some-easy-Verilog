module multiplier_4bit (
    input  logic [3:0] A,
    input  logic [3:0] B,
    output logic [7:0] P
);
    logic [3:0] pp0, pp1, pp2, pp3;
    logic [7:0] part0, part1, part2, part3;

    always_comb begin
        pp0 = A & {4{B[0]}};
        pp1 = A & {4{B[1]}};
        pp2 = A & {4{B[2]}};
        pp3 = A & {4{B[3]}};

        part0 = {4'b0000, pp0};            
        part1 = {3'b000,  pp1, 1'b0};      
        part2 = {2'b00,   pp2, 2'b00};    
        part3 = {1'b0,    pp3, 3'b000};    

        P = part0 + part1 + part2 + part3;
    end

endmodule
