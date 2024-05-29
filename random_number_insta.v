random_number rn_inst (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .min_value(min_value),
    .max_value(max_value),
    .random_output(random_output)
);