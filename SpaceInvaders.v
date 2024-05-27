/*modulo principal*/
module SpaceInvaders(
	input clk,
	input reset,
	input btn_A,
	input btn_B,
	input btn_C,
	input btn_D,
	output wire [10:0] posX_Nave, //liga SpaceInvaders com nave
	output wire [1:0] tiro_ativo,
    output wire [7:0] VGA_R,
    output wire [7:0] VGA_G,
    output wire [7:0] VGA_B,
    output wire VGA_BLANK_N,
    output wire VGA_SYNC_N,
    output wire VGA_HS,
    output wire VGA_VS,
    output wire VGA_CLK,
    output [6:0] HEX0, // digito da direita
    output [6:0] HEX1,
    output [6:0] HEX2,
    output [6:0] HEX3,
    output [6:0] HEX4,
    output [6:0] HEX5 // digito da esquerda
);

//Fios
wire [9:0] h_counter;
wire [9:0] v_counter;
wire [7:0] R_nave;
wire [7:0] G_nave;
wire [7:0] B_nave;
wire [7:0] R_municao1;
wire [7:0] G_municao1;
wire [7:0] B_municao1;
reg [19:0] contador;
reg [18:0] contador_botao;

//Modulos
reg [3:0] estado_barra;
reg [3:0] estado_bola;
reg [10:0] posX_Municao1;

nave nave(
    .h_counter(h_counter),
    .v_counter(v_counter),
	 .reset(reset),
	 .clk(clk),
	 .btn_A(btn_A),
	 .btn_B(btn_B),
	 .btn_C(btn_C),
	 .btn_D(btn_D),
	 .tiro_ativo(tiro_ativo),
    .posX_Nave(posX_Nave),
    .R(R_nave),
    .G(G_nave),
    .B(B_nave)
);

municao1 municao1(
    .h_counter(h_counter),
    .v_counter(v_counter),
	 .reset(reset),
	 .clk(clk),
	 .tiro_ativo(tiro_ativo),
	 .btn_D(btn_D),
    .posX_Nave(posX_Nave),
    .R(R_municao1),
    .G(G_municao1),
    .B(B_municao1)
);


vga vga(
    .VGA_CLK2(VGA_CLK2),
    .reset(reset),
    .h_counter(h_counter),
    .v_counter(v_counter),
    .VGA_BLANK_N(VGA_BLANK_N),
    .VGA_SYNC_N(VGA_SYNC_N),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS)
);

// Display

reg [11:0] pontuacao;
reg [11:0] record;
wire [11:0] placar_atual;
wire [11:0] placar_record;

assign placar_atual = pontuacao;
assign placar_record = record;


display display1(
    .entrada(placar_atual),
    .digito0(HEX0), // digito da direita
    .digito1(HEX1),
    .digito2(HEX2)// digito da esquerda
);

display display2(
    .entrada(placar_record),
    .digito0(HEX3), // digito da direita
    .digito1(HEX4),
    .digito2(HEX5)// digito da esquerda
);


// Circuitos
reg VGA_CLK2; // 25Mhz
assign VGA_CLK = VGA_CLK2;

reg [10:0] memo_X_nave;
reg [10:0] mem_X_nave;
reg [10:0] memo_X_bola;
reg [10:0] memo_Y_bola;
reg [10:0] mem_X_bola;
reg [10:0] mem_Y_bola;
reg [6:0] delta_X_bola;
reg [6:0] delta_Y_bola;

//Liga os fios
assign VGA_R = R_nave ^ R_municao1;
assign VGA_G = G_nave ^ G_municao1;
assign VGA_B = B_nave ^ B_municao1;
//assign posX_Nave2 = posX_Nave;


always @(posedge clk) begin
    VGA_CLK2 = ~VGA_CLK2;
end


endmodule