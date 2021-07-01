module tb() ;

reg clk, reset ;
reg [7:0] coin ;
reg [2:0]  drink_choose ;
wire [7:0] total_money ;
wire error ;

Vending a( clk, reset, coin, drink_choose, total_money, error ) ;

initial clk = 1'b1 ;
always #5 clk = ~clk ;

initial
	begin
		//測試數據B-1
		#10 reset = 1'b1 ;
		#10 reset = 1'b0 ;
		#10 coin = 10 ;				//投入十元
		#10 coin = 1 ;				//投入一元
		#10 coin = 10 ;				//投入十元
		#10 coin = 0 ;
		#10 drink_choose = 3 ;		//選擇購買咖啡
		#10 drink_choose = 0 ;		//結束
		
		//測試數據B-2
		#10 reset = 1'b1 ;
		#10 reset = 1'b0 ;
		#10 coin = 5 ;				//投入五元
		#10 coin = 10 ;				//投入十元
		#10 coin = 0 ;
		#10 drink_choose = 0 ;		//取消	
		
		#10 coin = 10 ;				//投入十元
		#10 coin = 10 ;				//投入十元
		#10 coin = 1 ;				//投入一元
		#10 coin = 1 ;				//投入一元
		#10 coin = 1 ;				//投入一元
		#10 coin = 1 ;				//投入一元
		#10 coin = 1 ;				//投入一元
		#10 coin = 0 ;
		#10 drink_choose = 4 ;		//選擇購買牛奶
		#10 drink_choose = 0 ;		//結束
		
		//測試數據B-3
		#10 reset = 1'b1 ;
		#10 reset = 1'b0 ;
		#10 coin = 5 ;				//投入五元
		#10 coin = 10 ;				//投入十元
		#10 coin = 0 ;
		#10 drink_choose = 0 ;		//取消

		#10 coin = 10 ;				//投入十元
		#10 coin = 10 ;				//投入十元
		#10 coin = 0 ;
		#10 drink_choose = 2 ;		//購買可樂
		#10 drink_choose = 0 ;
	
		#10 coin = 10 ;				//投入十元
		#10 coin = 10 ;				//投入十元
		#10 coin = 0 ;
		#10 drink_choose = 4 ;		//購買牛奶(錢不夠)
		#10 drink_choose = 0 ;

		#10 coin = 10 ;				//投入十元
		#10 coin = 0 ;
		#10 drink_choose = 1 ;		//購買茶
		#10 drink_choose = 0 ;

		#10 coin = 50 ;				//投入五十元
		#10 coin = 0 ;
		#10 drink_choose = 3 ;		//購買咖啡
		#10 drink_choose = 0 ; 		//結束  
      
		#20 $stop ;
	end

endmodule