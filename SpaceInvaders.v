module SpaceInvaders(
	input clk,
	input reset,
	input btn_A,
	input btn_B,
	input btn_C,
	input btn_D,
   output reg [7:0] VGA_R,
   output reg [7:0] VGA_G,
   output reg [7:0] VGA_B,
   output wire VGA_BLANK_N,
   output wire VGA_SYNC_N,
   output wire VGA_HS,
   output wire VGA_VS,
   output wire VGA_CLK 

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

// Variáveis intermediárias para as cores das naves
//Fios
reg [9:0] posX [7:0];
reg [9:0] posY [7:0];
wire [9:0] h_counter;
wire [9:0] v_counter;
wire [7:0] inimigoR [7:0];
wire [7:0] inimigoG [7:0];
wire [7:0] inimigoB [7:0];

// Inicializando as posições das naves
always @(reset) begin
    posX[0] <= 10'd200; posY[0] = 10'd50;
    posX[1] <= 10'd250; posY[1] = 10'd50;
    posX[2] <= 10'd300; posY[2] = 10'd50;
    posX[3] <= 10'd350; posY[3] = 10'd50;
    posX[4] <= 10'd400; posY[4] = 10'd50;
    posX[5] <= 10'd450; posY[5] = 10'd50;
    posX[6] <= 10'd500; posY[6] = 10'd50;
    posX[7] <= 10'd550; posY[7] = 10'd50;
end

// Instanciação das 8 naves usando generate
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : inimigos
        Inimigo1 inimigo_inst (
            .clk(clk),
            .posX(posX[i]),
            .posY(posY[i]),
            .h_counter(h_counter),
            .v_counter(v_counter),
            .reset(reset),
            .R(inimigoR[i]),
            .G(inimigoG[i]),
            .B(inimigoB[i])
        );
    end
endgenerate


// Declaração da variável de iteração fora do bloco always
integer j;

// Combinação das saídas das naves usando OR
always @(clk) begin
        // Inicialmente, as cores são pretas (fundo)
        VGA_R = 8'b0;
        VGA_G = 8'b0;
        VGA_B = 8'b0;
        
        // Verifica se algum pixel da nave está na posição atual
        for (j = 0; j < 8; j = j + 1) begin
                VGA_R = VGA_R | inimigoR[j];
                VGA_G = VGA_G | inimigoG[j];
                VGA_B = VGA_B | inimigoB[j];
        end
    end

// Circuitos
reg VGA_CLK2; // 25Mhz
assign VGA_CLK = VGA_CLK2;

always @(posedge clk) begin
    VGA_CLK2 = ~VGA_CLK2;
end

endmodule