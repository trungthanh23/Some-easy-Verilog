module comparator_3bit_tb;
    logic [2:0] a, b;
    logic lt, gt, eq;

    comparator_3bit dut (
        .a(a),
        .b(b),
        .lt(lt),
        .gt(gt),
        .eq(eq)
    );

    initial begin
        $display("Time\t a\t b\t lt\t gt\t eq");
        $display("-------------------------------------");

        a = 3'd3; b = 3'd5;
        #10;
        $display("%0t\t %d\t %d\t %b\t %b\t %b", $time, a, b, lt, gt, eq);

        a = 3'd6; b = 3'd2;
        #10;
        $display("%0t\t %d\t %d\t %b\t %b\t %b", $time, a, b, lt, gt, eq);

        a = 3'd4; b = 3'd4;
        #10;
        $display("%0t\t %d\t %d\t %b\t %b\t %b", $time, a, b, lt, gt, eq);

        a = 3'd0; b = 3'd7;
        #10;
        $display("%0t\t %d\t %d\t %b\t %b\t %b", $time, a, b, lt, gt, eq);

        a = 3'd7; b = 3'd1;
        #10;
        $display("%0t\t %d\t %d\t %b\t %b\t %b", $time, a, b, lt, gt, eq);

        #10;
        $stop;
    end

endmodule