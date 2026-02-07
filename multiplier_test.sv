module multiplier_4bit_tb();
    logic [3:0] A;
    logic [3:0] B;
    logic [7:0] P;
    multiplier_4bit  DUT (
    .A(A),
    .B(B),
    .P(P)
        
    );


task check(
    input [3:0] SBN_test,
    input [3:0] SN_test
);
    begin
       
        B = SBN_test;
        A = SN_test;
        #10;
        if (A * B == P) begin
            $display("%t Test passed, SBN = %d, SN = %d, Y = %d", $time, B, A, P);
        end else begin
            $display("%t Test failed, SBN = %d, SN = %d, Y = %d", $time, B, A, P);
            $stop;
        end
    end
endtask


    integer i,j;

    initial begin
        for(i = 0; i < 16; i = i + 1)begin
            for(j = 0; j < 16; j = j + 1)begin
                check(i, j);
            end
        end
        $finish;
    end

  

endmodule