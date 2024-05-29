module random_number (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [31:0] min_value,
    input wire [31:0] max_value,
    output wire [31:0] random_output
);

    reg [31:0] seed;
    reg [31:0] random_number;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            seed <= 0;
            random_number <= 0;
        end else if (enable) begin
            seed <= seed + 1;
            random_number <= (seed & (max_value - min_value)) + min_value;
        end
    end

    assign random_output = random_number;

endmodule

