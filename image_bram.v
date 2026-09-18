module image_bram (
    input wire clk,
    input wire [11:0] addr,
    output reg [15:0] dout
);

    reg [15:0] mem [0:4095];

    initial 
        begin
            $readmemh("CAT1.hex", mem);
        end

    always @(posedge clk) 
        begin
            dout <= mem[addr];
        end
endmodule