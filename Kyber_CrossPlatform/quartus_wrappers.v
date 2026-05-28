// mult_gen_0: A/B=12-bit signed, P=24-bit (2-cycle pipeline)
module mult_gen_0 (
    input  wire        CLK,
    input  wire [11:0] A,
    input  wire [11:0] B,
    output reg  [23:0] P
);
    reg [23:0] P_reg;
    always @(posedge CLK) begin
        P_reg <= $signed(A) * $signed(B);
        P     <= P_reg;
    end
endmodule

// c_shift_ram_0: depth=1, width=12
module c_shift_ram_0 (
    input  wire        CLK,
    input  wire        CE,
    input  wire [11:0] D,
    output wire [11:0] Q
);
    reg [11:0] sr;
    always @(posedge CLK) begin
        if (CE) sr <= D;
    end
    assign Q = sr;
endmodule

// c_shift_ram_1: depth=2, width=12
module c_shift_ram_1 (
    input  wire        CLK,
    input  wire        CE,
    input  wire [11:0] D,
    output wire [11:0] Q
);
    reg [11:0] sr [0:1];
    always @(posedge CLK) begin
        if (CE) begin
            sr[1] <= sr[0];
            sr[0] <= D;
        end
    end
    assign Q = sr[1];
endmodule

// c_shift_ram_2: depth=3, width=12
module c_shift_ram_2 (
    input  wire        CLK,
    input  wire        CE,
    input  wire [11:0] D,
    output wire [11:0] Q
);
    reg [11:0] sr [0:2];
    always @(posedge CLK) begin
        if (CE) begin
            sr[2] <= sr[1];
            sr[1] <= sr[0];
            sr[0] <= D;
        end
    end
    assign Q = sr[2];
endmodule

// c_shift_ram_3: depth=4, width=2
module c_shift_ram_3 (
    input  wire       CLK,
    input  wire       CE,
    input  wire [1:0] D,
    output wire [1:0] Q
);
    reg [1:0] sr [0:3];
    integer i3;
    always @(posedge CLK) begin
        if (CE) begin
            for (i3=3; i3>0; i3=i3-1) sr[i3] <= sr[i3-1];
            sr[0] <= D;
        end
    end
    assign Q = sr[3];
endmodule

// c_shift_ram_4: depth=5, width=6
module c_shift_ram_4 (
    input  wire       CLK,
    input  wire       CE,
    input  wire [5:0] D,
    output wire [5:0] Q
);
    reg [5:0] sr [0:4];
    integer i4;
    always @(posedge CLK) begin
        if (CE) begin
            for (i4=4; i4>0; i4=i4-1) sr[i4] <= sr[i4-1];
            sr[0] <= D;
        end
    end
    assign Q = sr[4];
endmodule

// c_shift_ram_5: depth=6, width=12
module c_shift_ram_5 (
    input  wire        CLK,
    input  wire        CE,
    input  wire [11:0] D,
    output wire [11:0] Q
);
    reg [11:0] sr [0:5];
    integer i5;
    always @(posedge CLK) begin
        if (CE) begin
            for (i5=5; i5>0; i5=i5-1) sr[i5] <= sr[i5-1];
            sr[0] <= D;
        end
    end
    assign Q = sr[5];
endmodule

// c_shift_ram_6: depth=7, width=8
module c_shift_ram_6 (
    input  wire       CLK,
    input  wire       CE,
    input  wire [7:0] D,
    output wire [7:0] Q
);
    reg [7:0] sr [0:6];
    integer i6;
    always @(posedge CLK) begin
        if (CE) begin
            for (i6=6; i6>0; i6=i6-1) sr[i6] <= sr[i6-1];
            sr[0] <= D;
        end
    end
    assign Q = sr[6];
endmodule

// c_shift_ram_8: depth=8, width=12
module c_shift_ram_8 (
    input  wire        CLK,
    input  wire        CE,
    input  wire [11:0] D,
    output wire [11:0] Q
);
    reg [11:0] sr [0:7];
    integer i8;
    always @(posedge CLK) begin
        if (CE) begin
            for (i8=7; i8>0; i8=i8-1) sr[i8] <= sr[i8-1];
            sr[0] <= D;
        end
    end
    assign Q = sr[7];
endmodule

// c_shift_ram_9: depth=9, width=12
module c_shift_ram_9 (
    input  wire        CLK,
    input  wire        CE,
    input  wire [11:0] D,
    output wire [11:0] Q
);
    reg [11:0] sr [0:8];
    integer i9;
    always @(posedge CLK) begin
        if (CE) begin
            for (i9=8; i9>0; i9=i9-1) sr[i9] <= sr[i9-1];
            sr[0] <= D;
        end
    end
    assign Q = sr[8];
endmodule

// c_shift_ram_11: depth=11, width=12
module c_shift_ram_11 (
    input  wire        CLK,
    input  wire        CE,
    input  wire [11:0] D,
    output wire [11:0] Q
);
    reg [11:0] sr [0:10];
    integer i11;
    always @(posedge CLK) begin
        if (CE) begin
            for (i11=10; i11>0; i11=i11-1) sr[i11] <= sr[i11-1];
            sr[0] <= D;
        end
    end
    assign Q = sr[10];
endmodule

// blk_mem_gen_0: True DP RAM, 24-bit wide, 128 deep (RAM0, RAM1)
module blk_mem_gen_0 (
    input  wire        clka,
    input  wire        ena,
    input  wire        wea,
    input  wire [6:0]  addra,
    input  wire [23:0] dina,
    output reg  [23:0] douta,
    input  wire        clkb,
    input  wire        enb,
    input  wire [6:0]  addrb,
    output reg  [23:0] doutb
);
    reg [23:0] mem [0:127];
    always @(posedge clka) begin
        if (ena) begin
            if (wea) mem[addra] <= dina;
            douta <= mem[addra];
        end
    end
    always @(posedge clkb) begin
        if (enb) doutb <= mem[addrb];
    end
endmodule

// blk_mem_gen_1: Simple DP RAM, 48-bit wide, 128 deep (RAM4)
module blk_mem_gen_1 (
    input  wire        clka,
    input  wire        ena,
    input  wire        wea,
    input  wire [6:0]  addra,
    input  wire [47:0] dina,
    input  wire        clkb,
    input  wire        enb,
    input  wire [6:0]  addrb,
    output reg  [47:0] doutb
);
    reg [47:0] mem [0:127];
    always @(posedge clka) begin
        if (ena && wea) mem[addra] <= dina;
    end
    always @(posedge clkb) begin
        if (enb) doutb <= mem[addrb];
    end
endmodule

// blk_mem_gen_2: True DP RAM, 24-bit wide, 64 deep (RAM2, RAM3)
module blk_mem_gen_2 (
    input  wire        clka,
    input  wire        ena,
    input  wire        wea,
    input  wire [5:0]  addra,
    input  wire [23:0] dina,
    output reg  [23:0] douta,
    input  wire        clkb,
    input  wire        enb,
    input  wire [5:0]  addrb,
    output reg  [23:0] doutb
);
    reg [23:0] mem [0:63];
    always @(posedge clka) begin
        if (ena) begin
            if (wea) mem[addra] <= dina;
            douta <= mem[addra];
        end
    end
    always @(posedge clkb) begin
        if (enb) doutb <= mem[addrb];
    end
endmodule

// dist_mem_gen_5/6/7: ROM, 12-bit, 128 deep, zero-initialized
module dist_mem_gen_5 (
    input  wire        clk,
    input  wire [6:0]  a,
    output reg  [11:0] spo,
    output reg  [11:0] qspo
);
    reg [11:0] rom5 [0:127];
    integer j5;
    initial begin
        for (j5=0; j5<128; j5=j5+1) rom5[j5] = 12'h0;
    end
    always @(posedge clk) begin
        spo  <= rom5[a];
        qspo <= rom5[a];
    end
endmodule

module dist_mem_gen_6 (
    input  wire        clk,
    input  wire [6:0]  a,
    output reg  [11:0] spo,
    output reg  [11:0] qspo
);
    reg [11:0] rom6 [0:127];
    integer j6;
    initial begin
        for (j6=0; j6<128; j6=j6+1) rom6[j6] = 12'h0;
    end
    always @(posedge clk) begin
        spo  <= rom6[a];
        qspo <= rom6[a];
    end
endmodule

module dist_mem_gen_7 (
    input  wire        clk,
    input  wire [6:0]  a,
    output reg  [11:0] spo,
    output reg  [11:0] qspo
);
    reg [11:0] rom7 [0:127];
    integer j7;
    initial begin
        for (j7=0; j7<128; j7=j7+1) rom7[j7] = 12'h0;
    end
    always @(posedge clk) begin
        spo  <= rom7[a];
        qspo <= rom7[a];
    end
endmodule

// fifo_generator_0: hash input FIFO, 36-bit wide, depth 16
module fifo_generator_0 (
    input  wire        clk,
    input  wire        srst,
    input  wire [35:0] din,
    input  wire        wr_en,
    input  wire        rd_en,
    output reg  [35:0] dout,
    output wire        full,
    output wire        empty
);
    reg [35:0] mem [0:15];
    reg [4:0] wr_ptr;
    reg [4:0] rd_ptr;
    reg [4:0] count;
    initial begin wr_ptr=0; rd_ptr=0; count=0; dout=0; end
    assign full  = (count == 16);
    assign empty = (count == 0);
    always @(posedge clk) begin
        if (srst) begin wr_ptr<=0; rd_ptr<=0; count<=0; end
        else begin
            if (wr_en && !full)  begin mem[wr_ptr[3:0]]<=din; wr_ptr<=wr_ptr+1; count<=count+1; end
            if (rd_en && !empty) begin dout<=mem[rd_ptr[3:0]]; rd_ptr<=rd_ptr+1; count<=count-1; end
            if (wr_en && !full && rd_en && !empty) count<=count;
        end
    end
endmodule

// fifo_generator_1: hash output FIFO 0, 24-bit wide, depth 256
module fifo_generator_1 (
    input  wire        clk,
    input  wire        srst,
    input  wire [23:0] din,
    input  wire        wr_en,
    input  wire        rd_en,
    output reg  [23:0] dout,
    output wire        full,
    output wire        empty
);
    reg [23:0] mem [0:255];
    reg [8:0] wr_ptr;
    reg [8:0] rd_ptr;
    reg [8:0] count;
    initial begin wr_ptr=0; rd_ptr=0; count=0; dout=0; end
    assign full  = (count == 256);
    assign empty = (count == 0);
    always @(posedge clk) begin
        if (srst) begin wr_ptr<=0; rd_ptr<=0; count<=0; end
        else begin
            if (wr_en && !full)  begin mem[wr_ptr[7:0]]<=din; wr_ptr<=wr_ptr+1; count<=count+1; end
            if (rd_en && !empty) begin dout<=mem[rd_ptr[7:0]]; rd_ptr<=rd_ptr+1; count<=count-1; end
            if (wr_en && !full && rd_en && !empty) count<=count;
        end
    end
endmodule

// fifo_generator_2: IFIFO, 32-bit wide, depth 32
module fifo_generator_2 (
    input  wire        clk,
    input  wire        srst,
    input  wire [31:0] din,
    input  wire        wr_en,
    input  wire        rd_en,
    output reg  [31:0] dout,
    output wire        full,
    output wire        empty
);
    reg [31:0] mem [0:31];
    reg [5:0] wr_ptr;
    reg [5:0] rd_ptr;
    reg [5:0] count;
    initial begin wr_ptr=0; rd_ptr=0; count=0; dout=0; end
    assign full  = (count == 32);
    assign empty = (count == 0);
    always @(posedge clk) begin
        if (srst) begin wr_ptr<=0; rd_ptr<=0; count<=0; end
        else begin
            if (wr_en && !full)  begin mem[wr_ptr[4:0]]<=din; wr_ptr<=wr_ptr+1; count<=count+1; end
            if (rd_en && !empty) begin dout<=mem[rd_ptr[4:0]]; rd_ptr<=rd_ptr+1; count<=count-1; end
            if (wr_en && !full && rd_en && !empty) count<=count;
        end
    end
endmodule

// fifo_generator_3: OFIFO, 34-bit wide, depth 512
module fifo_generator_3 (
    input  wire        clk,
    input  wire        srst,
    input  wire [33:0] din,
    input  wire        wr_en,
    input  wire        rd_en,
    output reg  [33:0] dout,
    output wire        full,
    output wire        empty
);
    reg [33:0] mem [0:511];
    reg [9:0] wr_ptr;
    reg [9:0] rd_ptr;
    reg [9:0] count;
    initial begin wr_ptr=0; rd_ptr=0; count=0; dout=0; end
    assign full  = (count == 512);
    assign empty = (count == 0);
    always @(posedge clk) begin
        if (srst) begin wr_ptr<=0; rd_ptr<=0; count<=0; end
        else begin
            if (wr_en && !full)  begin mem[wr_ptr[8:0]]<=din; wr_ptr<=wr_ptr+1; count<=count+1; end
            if (rd_en && !empty) begin dout<=mem[rd_ptr[8:0]]; rd_ptr<=rd_ptr+1; count<=count-1; end
            if (wr_en && !full && rd_en && !empty) count<=count;
        end
    end
endmodule

// fifo_generator_4: DFIFO0, 24-bit wide, depth 256, with prog_full (9-bit thresh)
module fifo_generator_4 (
    input  wire        clk,
    input  wire        srst,
    input  wire [23:0] din,
    input  wire        wr_en,
    input  wire        rd_en,
    input  wire [8:0]  prog_full_thresh,
    output reg  [23:0] dout,
    output wire        full,
    output wire        empty,
    output wire        prog_full
);
    reg [23:0] mem [0:255];
    reg [8:0] wr_ptr;
    reg [8:0] rd_ptr;
    reg [8:0] count;
    initial begin wr_ptr=0; rd_ptr=0; count=0; dout=0; end
    assign full      = (count == 256);
    assign empty     = (count == 0);
    assign prog_full = (count >= prog_full_thresh);
    always @(posedge clk) begin
        if (srst) begin wr_ptr<=0; rd_ptr<=0; count<=0; end
        else begin
            if (wr_en && !full)  begin mem[wr_ptr[7:0]]<=din; wr_ptr<=wr_ptr+1; count<=count+1; end
            if (rd_en && !empty) begin dout<=mem[rd_ptr[7:0]]; rd_ptr<=rd_ptr+1; count<=count-1; end
            if (wr_en && !full && rd_en && !empty) count<=count;
        end
    end
endmodule

// fifo_generator_5: DFIFO1, 10-bit wide, depth 256
module fifo_generator_5 (
    input  wire        clk,
    input  wire        srst,
    input  wire [9:0]  din,
    input  wire        wr_en,
    input  wire        rd_en,
    output reg  [9:0]  dout,
    output wire        full,
    output wire        empty
);
    reg [9:0] mem [0:255];
    reg [8:0] wr_ptr;
    reg [8:0] rd_ptr;
    reg [8:0] count;
    initial begin wr_ptr=0; rd_ptr=0; count=0; dout=0; end
    assign full  = (count == 256);
    assign empty = (count == 0);
    always @(posedge clk) begin
        if (srst) begin wr_ptr<=0; rd_ptr<=0; count<=0; end
        else begin
            if (wr_en && !full)  begin mem[wr_ptr[7:0]]<=din; wr_ptr<=wr_ptr+1; count<=count+1; end
            if (rd_en && !empty) begin dout<=mem[rd_ptr[7:0]]; rd_ptr<=rd_ptr+1; count<=count-1; end
            if (wr_en && !full && rd_en && !empty) count<=count;
        end
    end
endmodule

// fifo_generator_6: Client DFIFO, 24-bit wide, depth 256
module fifo_generator_6 (
    input  wire        clk,
    input  wire        srst,
    input  wire [23:0] din,
    input  wire        wr_en,
    input  wire        rd_en,
    output reg  [23:0] dout,
    output wire        full,
    output wire        empty
);
    reg [23:0] mem [0:255];
    reg [8:0] wr_ptr;
    reg [8:0] rd_ptr;
    reg [8:0] count;
    initial begin wr_ptr=0; rd_ptr=0; count=0; dout=0; end
    assign full  = (count == 256);
    assign empty = (count == 0);
    always @(posedge clk) begin
        if (srst) begin wr_ptr<=0; rd_ptr<=0; count<=0; end
        else begin
            if (wr_en && !full)  begin mem[wr_ptr[7:0]]<=din; wr_ptr<=wr_ptr+1; count<=count+1; end
            if (rd_en && !empty) begin dout<=mem[rd_ptr[7:0]]; rd_ptr<=rd_ptr+1; count<=count-1; end
            if (wr_en && !full && rd_en && !empty) count<=count;
        end
    end
endmodule

// fifo_generator_7: hash output FIFO 1, 25-bit wide, depth 256
module fifo_generator_7 (
    input  wire        clk,
    input  wire        srst,
    input  wire [24:0] din,
    input  wire        wr_en,
    input  wire        rd_en,
    output reg  [24:0] dout,
    output wire        full,
    output wire        empty
);
    reg [24:0] mem [0:255];
    reg [8:0] wr_ptr;
    reg [8:0] rd_ptr;
    reg [8:0] count;
    initial begin wr_ptr=0; rd_ptr=0; count=0; dout=0; end
    assign full  = (count == 256);
    assign empty = (count == 0);
    always @(posedge clk) begin
        if (srst) begin wr_ptr<=0; rd_ptr<=0; count<=0; end
        else begin
            if (wr_en && !full)  begin mem[wr_ptr[7:0]]<=din; wr_ptr<=wr_ptr+1; count<=count+1; end
            if (rd_en && !empty) begin dout<=mem[rd_ptr[7:0]]; rd_ptr<=rd_ptr+1; count<=count-1; end
            if (wr_en && !full && rd_en && !empty) count<=count;
        end
    end
endmodule

// fifo_generator_8: hash decode FIFO, 32-bit wide, depth 32
module fifo_generator_8 (
    input  wire        clk,
    input  wire        srst,
    input  wire [31:0] din,
    input  wire        wr_en,
    input  wire        rd_en,
    output reg  [31:0] dout,
    output wire        full,
    output wire        empty
);
    reg [31:0] mem [0:31];
    reg [5:0] wr_ptr;
    reg [5:0] rd_ptr;
    reg [5:0] count;
    initial begin wr_ptr=0; rd_ptr=0; count=0; dout=0; end
    assign full  = (count == 32);
    assign empty = (count == 0);
    always @(posedge clk) begin
        if (srst) begin wr_ptr<=0; rd_ptr<=0; count<=0; end
        else begin
            if (wr_en && !full)  begin mem[wr_ptr[4:0]]<=din; wr_ptr<=wr_ptr+1; count<=count+1; end
            if (rd_en && !empty) begin dout<=mem[rd_ptr[4:0]]; rd_ptr<=rd_ptr+1; count<=count-1; end
            if (wr_en && !full && rd_en && !empty) count<=count;
        end
    end
endmodule