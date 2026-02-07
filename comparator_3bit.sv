module comparator_3bit (
    input    [2:0] a,  
    input    [2:0] b,  
    output  lt,       
    output  gt,       
    output  eq       
);
    assign lt = (a < b);      
    assign gt = (a > b);      
    assign eq = (a == b);     
endmodule