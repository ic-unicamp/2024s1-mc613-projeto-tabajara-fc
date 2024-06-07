module random_number (
    input wire clk,
    input wire reset,
    input wire [31:0] max_value,
    output wire [8:0] random_output
);

localparam ATRASO_TIRO = 25'd15000000; // Ajuste conforme necessário

reg [8:0] numero;
integer i;
integer j;
reg [7:0] randon_x [0:23]; // Declara um array de 24 elementos, cada um de 8 bits
reg [2:0] randon_y [0:2]; // Declara um array de 3 elementos, cada um de 2 bits

always @(posedge clk) begin
    if (reset) begin
        i = 0;
        j = 0;
    end
    else begin
        numero = i;
        j = j + 1;
        if (j > ATRASO_TIRO - 1) begin
            i = i + 1;
            j = 0;
        end
        if (i > max_value - 1) begin
            i = 0;
        end    
    end
end
assign random_output = numero;
endmodule
