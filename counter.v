module counter(
input clk,
input rst,
input we,
output reg[3:0]COUNT
);
always@(posedge clk)
begin
if(rst)
COUNT<=4'b0000;
else if(we)
COUNT<=COUNT+1;
else
COUNT<=COUNT-1;
end
endmodule
