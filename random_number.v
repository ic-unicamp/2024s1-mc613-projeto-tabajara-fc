module random_number (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [31:0] max_value,
    output wire [31:0] random_output
);

reg [31:0] numero;
reg enable_prev;
integer i;
reg [7:0] my_array [0:15]; // Declara um array de 16 elementos, cada um de 8 bits

always @(posedge clk) begin
    if (reset) begin
        i = 0;
        my_array[0]  <= 8'd1;  // 1
        my_array[1]  <= 8'd2;  // 2
        my_array[2]  <= 8'd3;  // 3
        my_array[3]  <= 8'd4;  // 4
        my_array[4]  <= 8'd5;  // 5
        my_array[5]  <= 8'd1;  // 1
        my_array[6]  <= 8'd2;  // 2
        my_array[7]  <= 8'd3;  // 3
        my_array[8]  <= 8'd4;  // 4
        my_array[9]  <= 8'd5;  // 5
        my_array[10] <= 8'd1;  // 1
        my_array[11] <= 8'd2;  // 2
        my_array[12] <= 8'd3;  // 3
        my_array[13] <= 8'd4;  // 4
        my_array[14] <= 8'd5;  // 5
        my_array[15] <= 8'd1;  // 1
    end
    else begin
        if (enable && !enable_prev) begin
            numero = my_array[i];
            // numero = 2;
            i = i + 1;
        end
        if (i == 15) begin
            i = 0;
        end
        enable_prev = enable;
    end
end
assign random_output = numero;
endmodule
