module bin_to_bcd (

    input[11:0] entrada,
    output reg [11:0] bcd
);

integer i;

// Convertendo a entrada para BCD
always @(entrada) begin
    bcd = 0;
    for (i = 0; i < 12; i = i + 1) begin
        if (bcd[3:0] >= 5) begin
            bcd[3:0] = bcd[3:0] + 3;
        end
        if (bcd[7:4] >= 5) begin
            bcd[7:4] = bcd[7:4] + 3;
        end
        if (bcd[11:8] >= 5) begin
            bcd[11:8] = bcd[11:8] + 3;
        end
        
        bcd = {bcd[10:0], entrada[11 - i]};
    end
end


endmodule