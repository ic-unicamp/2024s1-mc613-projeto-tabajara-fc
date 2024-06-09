module tela_inicial (
    input wire clk,
    input wire reset,
    input wire h_counter,
    input wire v_counter,
    input wire troca,
    output wire [7:0] R,
    output wire [7:0] G,
    output wire [7:0] B
);

localparam POS_X = 200;
localparam POS_Y = 200;
localparam SEPARA = 200;

tela_derrota #(6) inimigo_inst (
    .clk(clk),
    .reset(reset),
    .posX(POS_X + SEPARA),
    .posY(POS_Y + SEPARA),
    .h_counter(h_counter),
    .v_counter(v_counter),
    .troca(troca),
    .R(R_inimigo),
    .G(G_inimigo),
    .B(B_inimigo)
);

desenha_x #(10) x_inst (
    .clk(clk),
    .reset(reset),
    .h_counter(h_counter),
    .v_counter(v_counter),
    .X_POS_X(POS_X),
    .X_POS_Y(POS_Y),
    .R(R_x),
    .G(G_x),
    .B(B_x)
);

tela_vitoria #(4) nave (
    .clk(clk),
    .reset(reset),
    .h_counter(h_counter),
    .v_counter(v_counter),
    .posX(POS_X - SEPARA),
    .posY(POS_Y - SEPARA),
    .R(R_nave),
    .G(G_nave),
    .B(B_nave)
);

wire [7:0] R_inimigo;
wire [7:0] G_inimigo;
wire [7:0] B_inimigo;
wire [7:0] R_x;
wire [7:0] G_x;
wire [7:0] B_x;
wire [7:0] R_nave;
wire [7:0] G_nave;
wire [7:0] B_nave;

assign R = R_inimigo | R_x | R_nave;
assign G = G_inimigo | G_x | G_nave;
assign B = B_inimigo | B_x | B_nave;

endmodule