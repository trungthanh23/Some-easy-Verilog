`timescale 1ns/1ps

module detect_1011_tb;

  logic clk, rst_n, x, y;
  logic [3:0] shift_reg;
  int pass_count = 0;
  int fail_count = 0;
  int total_bits = 100; 

  detect_1011 dut (
    .clk(clk),
    .rst_n(rst_n),
    .x(x),
    .y(y)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    rst_n = 0;
    #12;
    rst_n = 1;
  end

  initial begin
    shift_reg = 4'b0000;
    @(posedge rst_n); 

    for (int i = 0; i < total_bits; i++) begin
      x = $urandom_range(0, 1); 
      @(posedge clk);
      shift_reg = {shift_reg[2:0], x}; 

      if (shift_reg == 4'b1011) begin
        if (y == 1) begin
          $display("Time %0t: PASS - Detected 1011", $time);
          pass_count++;
        end else begin
          $display("Time %0t: FAIL - Missed 1011", $time);
          fail_count++;
        end
      end else begin
        if (y == 1) begin
          $display("Time %0t: FAIL - False positive", $time);
          fail_count++;
        end
      end
    end

    $display("\n=== Test Summary ===");
    $display("PASS: %0d", pass_count);
    $display("FAIL: %0d", fail_count);
    if (fail_count == 0)
      $display("All tests passed!");
    else
      $display("Some tests failed.");
    $finish;
  end
endmodule
