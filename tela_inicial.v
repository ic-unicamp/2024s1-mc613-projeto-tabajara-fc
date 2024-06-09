module MeuModulo (
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

Inimigo1 inimigo_inst (
    .clk(clk),
    .posX(POS_X + SEPARA),
    .posY(POS_Y + 200),
    .h_counter(h_counter),
    .v_counter(v_counter),
    .reset(),
    .btn_D(),
    .troca(troca),
    .posX_municao_player(),
    .posY_municao_player(),
    .R(R_inimigo),
    .G(G_inimigo),
    .B(B_inimigo),
    .colisao(),
    .vivo(),
    .venceu()
);

desenha_x x_inst (
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


nave nave(
	.reset(reset),
	.clk(clk),
    .h_counter(h_counter),
    .v_counter(v_counter),
	.btn_A(),
	.btn_B(),
	.btn_C(),
	.btn_D(),
	.posX_Municao2(),
	.posY_Municao2(),
	.tiro_ativo_jogador(),
	.vivo_jogador(),
   .posX_Nave(POS_X - SEPARA),
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

endmodule