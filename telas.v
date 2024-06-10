module telas(
    input clk,
    input reset,
    input [9:0] h_counter,
    input [9:0] v_counter,
    input [1:0] estado,
    input troca,
    output reg [7:0] R,
    output reg [7:8] G,
    output reg [7:8] B
);


wire [7:0] R_derrota;
wire [7:0] G_derrota;
wire [7:0] B_derrota;

wire [7:0] R_vitoria;
wire [7:0] G_vitoria;
wire [7:0] B_vitoria;


tela_vitoria tela_vitoria(
    //.clk(clk),
    .reset(reset),
    .h_counter(h_counter),
    .v_counter(v_counter),
    .R(R_vitoria),
    .G(G_vitoria),
    .B(B_vitoria)
);

tela_derrota tela_derrota(
    //.clk(clk),
    .reset(reset),
    .h_counter(h_counter),
    .v_counter(v_counter),
    .R(R_derrota),
    .G(G_derrota),
    .B(B_derrota)
);
tela_inicial tela_inicial(
    //.clk(clk),
    .reset(reset),
    .h_counter(h_counter),
    .v_counter(v_counter),
    .R(R_inicial),
    .G(G_inicial),
    .B(B_inicial)
);
always @(h_counter or v_counter or reset) begin
    case (estado)
        0: begin //tela inicial
            R = R_vitoria;
            G = G_vitoria;
            B = B_vitoria & 0;
        end
        1: begin //tela de jogo
            R = 0;
            G = 0;
            B = 0;
        end
        2: begin //tela de vitoria
            R = R_vitoria;
            G = G_vitoria;
            B = B_vitoria;
        end
        3: begin //tela de derrota
            R = R_derrota;
            G = G_derrota;
            B = B_derrota;
        end
    endcase
end
endmodule