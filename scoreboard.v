module scoreboard #(parameter DATA_WIDTH = 4, GOLDEN_WIDTH = 5, INPUT_WIDTH = 10);
    // Tín hiệu chung
    reg [INPUT_WIDTH-1:0] input_data [0:511];  // Mảng lưu các dòng từ input.txt
    reg [GOLDEN_WIDTH-1:0] golden [0:511];    // Mảng lưu giá trị từ golden.txt
    reg [DATA_WIDTH-1:0] a, b;                // Giá trị đầu vào
    reg op;                                   // Tín hiệu điều khiển op
    wire [GOLDEN_WIDTH-1:0] result;           // Đầu ra từ module
    wire carry_out;                           // Carry-out từ module
    reg [GOLDEN_WIDTH-1:0] expected;          // Kết quả mong muốn
    integer i;                                // Chỉ số duyệt
    integer mismatch_count;                   // Đếm số lỗi

    // Kết nối module DUT (Device Under Test)
    add_sub_bit #(DATA_WIDTH) uut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .carry_out(carry_out)
    );

    initial begin
        // Khởi tạo
        mismatch_count = 0;

        // Đọc dữ liệu từ file input.txt và golden.txt
        $readmemb("E:/Code/Learn/Verilog/Homework/ALU n bit/n bit unsigned/input.txt", input_data);  // Đọc toàn bộ dòng input
        $readmemb("E:/Code/Learn/Verilog/Homework/ALU n bit/n bit unsigned/golden.txt", golden);    // Đọc giá trị mong muốn

        // Xử lý từng dòng input và so sánh với golden
        for (i = 0; i < 511; i = i + 1) begin
            // Phân chia input thành a, b, và op
            a = input_data[i][INPUT_WIDTH-1:INPUT_WIDTH-DATA_WIDTH];
            b = input_data[i][INPUT_WIDTH-DATA_WIDTH-1:INPUT_WIDTH-2*DATA_WIDTH];
            op = input_data[i][0];

            expected = golden[i];  // Giá trị mong muốn
            #10; // Chờ module xử lý đầu ra

            if (result !== expected) begin
                $display("Mismatch at index %0d: A = %h, B = %h, OP = %b, Output = %h, Expected = %h",
                         i, a, b, op, result, expected);
                mismatch_count = mismatch_count + 1;
            end
        end

        // Báo cáo kết quả
        if (mismatch_count == 0) begin
            $display("All outputs match the golden file. Module is correct.");
        end else begin
            $display("Module is incorrect. Total mismatches: %0d", mismatch_count);
        end
    end
endmodule