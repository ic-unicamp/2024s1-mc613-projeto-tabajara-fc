module telas (
    input wire clk,
    input wire reset,
    input wire h_counter,
    input wire v_counter,
    input wire troca,
    input wire [1:0] modo,
    output wire [7:0] R,
    output wire [7:0] G,
    output wire [7:0] B
);

// Parametros de posição do centro da tela
    localparam POS_X = 200;
    localparam POS_Y = 200;


tela_inicial tela_inicial_inst (
    .clk(clk),
    .reset(reset),
    .h_counter(h_counter),
    .v_counter(v_counter),
    .troca(troca),
    .R(R_inicial),
    .G(G_inicial),
    .B(B_inicial)
);

tela_derrota #(10) tela_derrota(
    .clk(clk),
    .reset(reset),
    .h_counter(h_counter),
    .v_counter(v_counter),
    .pos_X(POS_X),
    .pos_Y(POS_Y),
    .R(R_derrota),
    .G(G_derrota),
    .B(B_derrota)
);

tela_vitoria #(6) tela_vitoria(
    .clk(clk),
    .reset(reset),
    .h_counter(h_counter),
    .v_counter(v_counter),
    .pos_X(POS_X),
    .pos_Y(POS_Y),
    .R(R_vitoria),
    .G(G_vitoria),
    .B(B_vitoria)
);

wire [7:0] R_derrota;
wire [7:0] G_derrota;
wire [7:0] B_derrota;

wire [7:0] R_vitoria;
wire [7:0] G_vitoria;
wire [7:0] B_vitoria;

wire [7:0] R_inicial;
wire [7:0] G_inicial;
wire [7:0] B_inicial;

reg [7:0] R_real;
reg [7:0] G_real;
reg [7:0] B_real;

always @(posedge clk) begin
    case (modo)
        0: begin
            R_real = R_inicial;
            G_real = G_inicial;
            B_real = B_inicial;
        end
        2: begin
            R_real = R_vitoria;
            G_real = G_vitoria;
            B_real = B_vitoria;
        end
        3: begin
            R_real = R_derrota;
            G_real = G_derrota;
            B_real = B_derrota;
        end
    endcase
end

assign R = R_real;
assign G = G_real;
assign B = B_real;

endmodule