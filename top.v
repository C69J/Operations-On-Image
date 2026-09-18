module top(
    input clk,
    output Hsync,
    output Vsync,
    input  wire [1:0]mode,    // 00=normal, 01=negative, 10=bright inc, 11=bright dec
    output [3:0] Red,
    output [3:0] Green,
    output [3:0] Blue
);
    
    //CLOCK
    wire clk25;
    clock_divider u1(
        .clk(clk), 
        .clk25(clk25));
   
   
   //VGA
    wire [9:0] x, y;
    wire video_on;

    vga_timing vga(
        .clk25(clk25), 
        .Hsync(Hsync), 
        .Vsync(Vsync), 
        .x(x), 
        .y(y), 
        .video_on(video_on)
    );
    
    
    //BRAM
    reg [11:0] addr;
    wire [15:0] pixel;

    image_bram img(
       .clk(clk25),
       .addr(addr),
       .dout(pixel)
   );
   
   
   //PIPELINE
   reg [9:0] x_r, y_r;
   reg video_on_r;

    always @(posedge clk25)
     begin
        x_r <= x;
        y_r <= y;
        video_on_r <= video_on;
     end


//IMAGE POSITIONING
localparam X_START = 288;
localparam Y_START = 208;


//ADDRESS GENERATION
always @* begin
    if (video_on_r &&
        x_r >= X_START && x_r < X_START + 64 &&
        y_r >= Y_START && y_r < Y_START + 64)
        addr = (y_r - Y_START) * 64 + (x_r - X_START);
    else
        addr = 0;
end

wire draw_img =
    video_on_r &&
    x_r >= X_START && x_r < X_START + 64 &&
    y_r >= Y_START && y_r < Y_START + 64;
    
//IMAGE PROCESSOR
wire [15:0] pixel_proc;

    image_processor img_proc(
        .pixel_in(pixel),
        .mode(mode),
        .pixel_out(pixel_proc)
    );

//VGA OUTPUT
assign Red   = draw_img ? pixel_proc[15:12] : 4'd0;  // top 4 bits of red
assign Green = draw_img ? pixel_proc[10:7]  : 4'd0;  // top 4 bits of green
assign Blue  = draw_img ? pixel_proc[4:1]   : 4'd0;  // top 4 bits of blue
    

endmodule