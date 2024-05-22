module top1(
	input clk,
	input reset,
	input btn_A,
	input btn_B,
	input btn_C,
	input btn_D,
   output wire [7:0] VGA_R,
   output wire [7:0] VGA_G,
   output wire [7:0] VGA_B,
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


//Fios
wire [9:0] h_counter;
wire [9:0] v_counter;

// Circuitos
reg VGA_CLK2; // 25Mhz
assign VGA_CLK = VGA_CLK2;

always @(posedge clk) begin
    VGA_CLK2 = ~VGA_CLK2;
end

endmodule