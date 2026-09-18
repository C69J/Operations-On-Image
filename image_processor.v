module image_processor(
    input  wire [15:0]pixel_in,
    input  wire [1:0]mode,
    output wire [15:0]pixel_out
);

    // RGB565 split
    wire [4:0] r = pixel_in[15:11];
    wire [5:0] g = pixel_in[10:5];
    wire [4:0] b = pixel_in[4:0];

    //NEGATIVE
    wire [4:0] r_neg = 5'd31 - r;
    wire [5:0] g_neg = 6'd63 - g;
    wire [4:0] b_neg = 5'd31 - b;

    //BRIGHTNESS
    localparam BR = 5'd6;

    wire [4:0] r_inc = (r + BR > 31) ? 31 : r + BR;
    wire [5:0] g_inc = (g + BR > 63) ? 63 : g + BR;
    wire [4:0] b_inc = (b + BR > 31) ? 31 : b + BR;

    wire [4:0] r_dec = (r < BR) ? 0 : r - BR;
    wire [5:0] g_dec = (g < BR) ? 0 : g - BR;
    wire [4:0] b_dec = (b < BR) ? 0 : b - BR;
    
    
    //MODE SELECT
    assign pixel_out =
        (mode == 2'b00) ? pixel_in :
        (mode == 2'b01) ? {r_neg, g_neg, b_neg} :
        (mode == 2'b10) ? {r_inc, g_inc, b_inc} :
                          {r_dec, g_dec, b_dec};

endmodule