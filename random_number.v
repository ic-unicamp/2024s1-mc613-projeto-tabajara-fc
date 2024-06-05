module random_number (
    input wire clk,
    input wire reset,
    output wire [31:0] random_output
);

reg [31:0] numero;
integer i;
reg [7:0] randon_list [0:99]; // Declara um array de 16 elementos, cada um de 8 bits

always @(posedge clk) begin
    if (reset) begin
        i = 0;
        randon_list[0]  <= 8'd15;  // 15
        randon_list[1]  <= 8'd3;   // 3
        randon_list[2]  <= 8'd20;  // 20
        randon_list[3]  <= 8'd8;   // 8
        randon_list[4]  <= 8'd5;   // 5
        randon_list[5]  <= 8'd11;  // 11
        randon_list[6]  <= 8'd18;  // 18
        randon_list[7]  <= 8'd1;   // 1
        randon_list[8]  <= 8'd21;  // 21
        randon_list[9]  <= 8'd6;   // 6
        randon_list[10] <= 8'd13;  // 13
        randon_list[11] <= 8'd2;   // 2
        randon_list[12] <= 8'd17;  // 17
        randon_list[13] <= 8'd9;   // 9
        randon_list[14] <= 8'd4;   // 4
        randon_list[15] <= 8'd22;  // 22
        randon_list[16] <= 8'd7;   // 7
        randon_list[17] <= 8'd14;  // 14
        randon_list[18] <= 8'd10;  // 10
        randon_list[19] <= 8'd19;  // 19
        randon_list[20] <= 8'd0;   // 0
        randon_list[21] <= 8'd16;  // 16
        randon_list[22] <= 8'd23;  // 23
        randon_list[23] <= 8'd12;  // 12
        randon_list[24] <= 8'd5;   // 5
        randon_list[25] <= 8'd7;   // 7
        randon_list[26] <= 8'd14;  // 14
        randon_list[27] <= 8'd1;   // 1
        randon_list[28] <= 8'd10;  // 10
        randon_list[29] <= 8'd17;  // 17
        randon_list[30] <= 8'd3;   // 3
        randon_list[31] <= 8'd20;  // 20
        randon_list[32] <= 8'd6;   // 6
        randon_list[33] <= 8'd22;  // 22
        randon_list[34] <= 8'd9;   // 9
        randon_list[35] <= 8'd13;  // 13
        randon_list[36] <= 8'd0;   // 0
        randon_list[37] <= 8'd18;  // 18
        randon_list[38] <= 8'd8;   // 8
        randon_list[39] <= 8'd11;  // 11
        randon_list[40] <= 8'd15;  // 15
        randon_list[41] <= 8'd2;   // 2
        randon_list[42] <= 8'd12;  // 12
        randon_list[43] <= 8'd21;  // 21
        randon_list[44] <= 8'd4;   // 4
        randon_list[45] <= 8'd16;  // 16
        randon_list[46] <= 8'd19;  // 19
        randon_list[47] <= 8'd23;  // 23
        randon_list[48] <= 8'd7;   // 7
        randon_list[49] <= 8'd10;  // 10
        randon_list[50]  <= 8'd15;  // 15
        randon_list[51]  <= 8'd3;   // 3
        randon_list[52]  <= 8'd22;  // 22
        randon_list[53]  <= 8'd8;   // 8
        randon_list[54]  <= 8'd10;  // 10
        randon_list[55]  <= 8'd14;  // 14
        randon_list[56]  <= 8'd21;  // 21
        randon_list[57]  <= 8'd0;   // 0
        randon_list[58]  <= 8'd19;  // 19
        randon_list[59]  <= 8'd5;   // 5
        randon_list[60] <= 8'd11;  // 11
        randon_list[61] <= 8'd2;   // 2
        randon_list[62] <= 8'd20;  // 20
        randon_list[63] <= 8'd7;   // 7
        randon_list[64] <= 8'd1;   // 1
        randon_list[65] <= 8'd16;  // 16
        randon_list[66] <= 8'd18;  // 18
        randon_list[67] <= 8'd9;   // 9
        randon_list[68] <= 8'd13;  // 13
        randon_list[69] <= 8'd6;   // 6
        randon_list[70] <= 8'd12;  // 12
        randon_list[71] <= 8'd23;  // 23
        randon_list[72] <= 8'd4;   // 4
        randon_list[73] <= 8'd17;  // 17
        randon_list[74] <= 8'd10;  // 10
        randon_list[75] <= 8'd3;   // 3
        randon_list[76] <= 8'd8;   // 8
        randon_list[77] <= 8'd15;  // 15
        randon_list[78] <= 8'd7;   // 7
        randon_list[79] <= 8'd19;  // 19
        randon_list[80] <= 8'd22;  // 22
        randon_list[81] <= 8'd1;   // 1
        randon_list[82] <= 8'd11;  // 11
        randon_list[83] <= 8'd6;   // 6
        randon_list[84] <= 8'd0;   // 0
        randon_list[85] <= 8'd4;   // 4
        randon_list[86] <= 8'd14;  // 14
        randon_list[87] <= 8'd23;  // 23
        randon_list[88] <= 8'd12;  // 12
        randon_list[89] <= 8'd2;   // 2
        randon_list[90] <= 8'd21;  // 21
        randon_list[91] <= 8'd9;   // 9
        randon_list[92] <= 8'd17;  // 17
        randon_list[93] <= 8'd5;   // 5
        randon_list[94] <= 8'd20;  // 20
        randon_list[95] <= 8'd18;  // 18
        randon_list[96] <= 8'd13;  // 13
        randon_list[97] <= 8'd16;  // 16
        randon_list[98] <= 8'd10;  // 10
        randon_list[99] <= 8'd3;   // 3
    end
    else begin
        numero = randon_list[i];
        i = i + 1;
        if (i == 100) begin
            i = 0;
        end
    end
end
assign random_output = numero;
endmodule
