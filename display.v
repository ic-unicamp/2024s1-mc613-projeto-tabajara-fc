module display (

    input[11:0] entrada,
    output wire [6:0] digito0,
    output wire [6:0] digito1,
    output wire [6:0] digito2
);
wire [11:0] bcd;
reg [3:0] atual0, atual1, atual2;
wire pos0, pos1, pos2;

assign pos0 = 1;
assign pos1 = 0;
assign pos2 = 0;

bin_to_bcd b2bcd (
    .entrada(entrada),
    .bcd(bcd)
);

bcd_display u0 (
    .bcd(atual0),
    .first(pos0),
    .saida(digito0)
);
bcd_display u1 (
    .bcd(atual1),
    .first(pos1),
    .saida(digito1)
);
bcd_display u2 (
    .bcd(atual2),
    .first(pos2),
    .saida(digito2)
);

always @(bcd) begin
    atual0 = bcd[3:0];
end
always @(bcd) begin
    atual1 = bcd[7:4];
end
always @(bcd) begin
    atual2 = bcd[11:8];
end

endmodule