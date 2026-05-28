`timescale 1ns / 1ps
module Kyber_tb();

reg clk, rst, start;
reg [2:0] k;
wire ready_pk, ready_c;
wire req_pk, req_c;
wire valid_server, valid_client;
wire [31:0] dout_server;
wire [31:0] dout_client;
//wire ofifo_req;
//reg ofifo_req_r1;
//wire [31:0] ofifo_dout;
//integer fp_inter;
//initial fp_inter = $fopen("ofifo_data.txt","w");

//always @(posedge clk) begin
//    ofifo_req_r1 <= ofifo_req;
//    if(ofifo_req_r1)
//        $fdisplay(fp_inter,"%h",ofifo_dout);
//end

integer fp_out_ser, fp_out_cli;
initial fp_out_ser = $fopen("output_ser.txt","w");
initial fp_out_cli = $fopen("output_cli.txt","w");

always @(posedge clk) begin
    if(valid_server) begin
        $fdisplay(fp_out_ser,"%h",dout_server);
        $fflush(fp_out_ser);
        $display("SERVER_VALID t=%0t data=%h",$time,dout_server);
    end
    if(valid_client) begin
        $fdisplay(fp_out_cli,"%h",dout_client);
        $fflush(fp_out_cli);
        $display("CLIENT_VALID t=%0t data=%h",$time,dout_client);
    end
end

initial begin
    #200000000;
    $fclose(fp_out_ser);
    $fclose(fp_out_cli);
    $finish;
end

always #5 clk = ~clk;

initial begin
	#0 clk = 1'd 0;
	rst = 1'd 0;
	start = 1'd 0;
	k = 3'd 4;
	#10 rst = 1'd 1;
	#100 rst = 1'd 0;
	#50 start = 1'd 1;
	#20 start = 1'd 0;
end
Kyber_Server S(
//.ofifo_req_t(ofifo_req),
//.ofifo_dout_t(ofifo_dout),
.clk(clk),
.rst(rst),
.start(start),
.wen(valid_client),
.k(k),
.din(dout_client),
.ready_pk(ready_pk),
.ready_c(ready_c),
.req_pk(req_pk),
.req_c(req_c),
.valid(valid_server),
.dout(dout_server)
);
Kyber_Client C(
//.ofifo_req_t(ofifo_req),
//.ofifo_dout_t(ofifo_dout),
.clk(clk),
.rst(rst),
.start(start),
.wen(valid_server),
.k(k),
.din(dout_server),
.ready_pk(ready_pk),
.ready_c(ready_c),
.req_pk(req_pk),
.req_c(req_c),
.valid(valid_client),
.dout(dout_client)
);

initial #500000000 $fclose(fp_out_ser);
initial #500000000 $fclose(fp_out_cli);

endmodule