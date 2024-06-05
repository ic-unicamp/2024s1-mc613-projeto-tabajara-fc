module random_number (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [31:0] max_value,
    output wire [31:0] random_output
);

reg [31:0] lfsr;
reg enable_prev;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        lfsr <= 32'h4c93; // Valor inicial não pode ser 0
        enable_prev <= 0;
    end else begin
        if (enable && !enable_prev) begin // borda de subida do enable
            lfsr <= {lfsr[30:0], lfsr[31] ^ lfsr[21] ^ lfsr[1] ^ lfsr[0]}; // Polinômio de feedback: x^32 + x^22 + x^2 + x + 1
        end
        enable_prev <= enable;
    end
end


assign random_output = (lfsr > max_value) ? max_value : lfsr;

endmodule
