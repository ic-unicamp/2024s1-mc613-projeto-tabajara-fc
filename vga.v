module vga(
    input VGA_CLK2,
    input reset,
    output reg [9:0] h_counter,
    output reg [9:0] v_counter,
    output wire VGA_BLANK_N,
    output wire VGA_SYNC_N,
    output wire VGA_HS,
    output wire VGA_VS
);

// implemente seu módulo aqui

// Sinais internos
reg [2:0] estado;
reg [2:0] estado_v;
reg enable;
wire Ativo;

always @(posedge VGA_CLK2) begin
    if (reset) begin
        h_counter = 0;
        v_counter = 0;
    end else begin
        h_counter = h_counter + 1;
        if (h_counter == 800) begin
            h_counter = 0;
            v_counter = v_counter + 1;
            if (v_counter == 525) begin
                v_counter = 0;
            end
        end
    end
end


assign VGA_BLANK_N = 1;
assign VGA_SYNC_N = 1;

assign VGA_HS = (h_counter < 96)? 0: 1;
assign VGA_VS = (v_counter < 2)? 0: 1;
assign Ativo  = ((h_counter > 96) && (v_counter > 2))? 1: 0;

// assign VGA_R = (Ativo)? 8'b11111111: 8'b0;
// assign VGA_G = (Ativo)? 8'b11111111: 8'b0;
// assign VGA_B = (Ativo)? 8'b11111111: 8'b0;

endmodule