module random_number (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [31:0] max_value,
    output wire [31:0] random_output
);

reg [31:0] numero;
reg enable_prev;
// reg [31:0] ciclo;

// always @(posedge clk or posedge reset) begin
//     if (reset) begin
//         lfsr = 32'h4c93; // Valor inicial não pode ser 0
//         enable_prev = 0;
//         ciclo = 0;
//     end else begin
//         if (enable && !enable_prev) begin // borda de subida do enable
//             lfsr = {lfsr[30:0], lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0]}; // Polinômio de feedback: x^32 + x^22 + x^2 + x + 1
//         end
//         enable_prev = enable;
//         if (lfsr > max_value) begin
//             lfsr = ciclo;
//             ciclo = ciclo + 1;
//         end
//     end

// end
integer i;
reg [7:0] my_array [0:15]; // Declara um array de 16 elementos, cada um de 8 bits

always @(posedge clk) begin
    if (reset) begin
        numero = 0;
        i = 0;
        my_array[0]  <= 8'h12;  // 18
        my_array[1]  <= 8'h2D;  // 45
        my_array[2]  <= 8'h3A;  // 58
        my_array[3]  <= 8'h4F;  // 79
        my_array[4]  <= 8'h07;  // 7
        my_array[5]  <= 8'h5A;  // 90
        my_array[6]  <= 8'h21;  // 33
        my_array[7]  <= 8'h36;  // 54
        my_array[8]  <= 8'h0C;  // 12
        my_array[9]  <= 8'h48;  // 72
        my_array[10] <= 8'h15;  // 21
        my_array[11] <= 8'h27;  // 39
        my_array[12] <= 8'h51;  // 81
        my_array[13] <= 8'h09;  // 9
        my_array[14] <= 8'h33;  // 51
        my_array[15] <= 8'h42;  // 66
    end
    else begin
        if (enable && !enable_prev) begin
            numero = my_array[i];
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
