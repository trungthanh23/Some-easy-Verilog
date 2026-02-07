module FIFO #(
    parameter DATA_WIDTH = 8, 
    parameter DEPTH      = 8  
)(
    input                       clk,
    input                       reset_n,

    // Write Interface
    input      [DATA_WIDTH-1:0] data_i,
    input                       wr_en,
    output                      full,

    // Read Interface
    output reg [DATA_WIDTH-1:0] data_o,
    input                       rd_en,
    output                      empty
);

    localparam PTR_WIDTH = $clog2(DEPTH);
    localparam CNT_WIDTH = $clog2(DEPTH + 1);

    reg [DATA_WIDTH-1:0]    fifo_mem [0 : DEPTH-1];
    reg [PTR_WIDTH-1:0]     wr_ptr;
    reg [PTR_WIDTH-1:0]     rd_ptr;
    reg [CNT_WIDTH-1:0]     count;

    assign full  = (count == DEPTH);
    assign empty = (count == 0);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            wr_ptr <= 0;
        end else begin
            if (wr_en && !full) begin
                fifo_mem[wr_ptr] <= data_i;
                if (wr_ptr == DEPTH - 1) begin
                    wr_ptr <= 0;
                end else begin
                    wr_ptr <= wr_ptr + 1;
                end
            end
        end
    end

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            rd_ptr <= 0;
            data_o <= 0;
        end else begin
            if (rd_en && !empty) begin
                data_o <= fifo_mem[rd_ptr];
                if (rd_ptr == DEPTH - 1) begin
                    rd_ptr <= 0; 
                end else begin
                    rd_ptr <= rd_ptr + 1;
                end
            end
        end
    end

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            count <= 0;
        end else begin
            wire write_op = wr_en && !full;
            wire read_op  = rd_en && !empty;

            case ({write_op, read_op})
                2'b10:  count <= count + 1; 
                2'b01:  count <= count - 1; 
                2'b11:  count <= count; 
                2'b00:  count <= count;
                default: count <= count;
            endcase
        end
    end

endmodule