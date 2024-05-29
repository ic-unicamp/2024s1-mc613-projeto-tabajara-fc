module bcd_display (
    input [3:0] bcd,
    input first,
    output reg [6:0] saida
);

always @(bcd) begin
    // Convertendo BCD para DE1-SoC onde 0 é aceso
    if (first) begin
        case (bcd)
            4'b0000: saida = 7'b1000000;
            4'b0001: saida = 7'b1111001;
            4'b0010: saida = 7'b0100100;
            4'b0011: saida = 7'b0110000;
            4'b0100: saida = 7'b0011001;
            4'b0101: saida = 7'b0010010;
            4'b0110: saida = 7'b0000010;
            4'b0111: saida = 7'b1111000;
            4'b1000: saida = 7'b0000000;
            4'b1001: saida = 7'b0011000;
        endcase
    end else begin
        case (bcd)
            4'b0000: saida = 7'b1111111;
            4'b0001: saida = 7'b1111001;
            4'b0010: saida = 7'b0100100;
            4'b0011: saida = 7'b0110000;
            4'b0100: saida = 7'b0011001;
            4'b0101: saida = 7'b0010010;
            4'b0110: saida = 7'b0000010;
            4'b0111: saida = 7'b1111000;
            4'b1000: saida = 7'b0000000;
            4'b1001: saida = 7'b0011000;
        endcase
    end    
end

endmodule