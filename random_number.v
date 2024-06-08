module random_number (
    input wire clk,
    input wire reset,
    input wire [31:0] max_value,
    output wire [8:0] random_output
);

localparam ATRASO_TIRO = 25'd 200000; // Ajuste conforme necessário

reg [8:0] numero;
integer i;
integer j;
reg agora;
reg [7:0] randon_x [0:23]; // Declara um array de 24 elementos, cada um de 8 bits
reg [2:0] randon_y [0:2]; // Declara um array de 3 elementos, cada um de 2 bits


always @(posedge clk) begin
    if (reset) begin
        i = 0;
        agora = 0;
    end
    else begin
        i = i + 1;
        agora = 0;
        if (i > ATRASO_TIRO - 1) begin
            i = 0;
            agora = 1;
        end
    end
end

always @(posedge clk) begin
    if (reset) begin
        j = 0;
        numero = 0;
    end
    else if(agora) begin
        if (j == max_value - 1) begin
            j = 0;
        end
        else begin
            j = j + 1;
        end
        numero = j;
    end
end

assign random_output = numero;


endmodule
