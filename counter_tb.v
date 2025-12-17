module counter_tb();
reg clk;
reg rst;
reg we;
wire [3:0] COUNT;
counter uut(.clk(clk),.rst(rst),.we(we),.COUNT(COUNT));
initial 
begin
clk=0;
forever #5 clk=~clk;
end
initial
begin
rst=1'b1;#10;
we=1'b0;#10;
rst=1'b0;we=1'b1;#10;
rst=1'b0;we=1'b1;#10;
rst=1'b0;we=1'b1;#10;
rst=1'b0;we=1'b0;#10;
rst=1'b0;we=1'b0;#10;
rst=1'b1;#10;
$finish;#20;
end
endmodule
