module Vending( clk, reset, input_money, choice, total_money, error ) ;

input clk, reset;
input [7:0] input_money ;
input [2:0] choice ;
output [7:0] total_money ;
output error ;

reg [7:0] money ;
reg [2:0] state ;
reg [2:0] next_state ;
reg [7:0] total_money ;
reg error ;
parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3 ;

always @ ( clk or reset )
begin
  if ( reset )
  begin
	state = S0 ;
	total_money = 0 ;
	error = 0 ;
  end
  
  else
	  state = next_state ;
end

always @ ( state or input_money or choice )
begin
	case( state )
		S0:
		begin
			if( input_money == 1 || input_money == 5 || input_money == 10 || input_money == 50 )
			begin
				total_money = total_money + input_money ;
        
				if( total_money < 10 && total_money > 0 )     // lowest price
					$display( "coin: %d,	total %d dollars", input_money, total_money ) ;
			end
			
			else if( input_money != 0 )
				$display( "error coin: %d", input_money ) ;

		end
		
		S1:
		begin
			if( total_money >= 25 && input_money != 0 )
				$display( "coin: %d,	total %d dollars	tea | coke | coffee | milk", input_money , total_money ) ;
			else if( total_money >= 20 && input_money != 0 )
				$display( "coin: %d,	total %d dollars	tea | coke | coffee", input_money , total_money ) ;
			else if( total_money >= 15 && input_money != 0 )
				$display( "coin: %d,	total %d dollars	tea | coke", input_money , total_money ) ;
			else if( total_money >= 10 && input_money != 0 )
				$display( "coin: %d,	total %d dollars	tea", input_money , total_money ) ;
		end
		
		S2:
		begin
			if( choice != 0 )
			begin
				if( choice == 1 && total_money >= 10 )
				begin
					total_money = total_money - 10 ;
					$display( "tea out" ) ;
					error = 0 ;
				end
				
				else if( choice == 2 && total_money >= 15 )
				begin
					total_money = total_money - 15 ;
					$display( "coke out" ) ;
					error = 0 ;
				end
				
				else if( choice == 3 && total_money >= 20 )
				begin
					total_money = total_money - 20 ;
					$display( "coffee out" ) ;
					error = 0 ;
				end
				
				else if( choice == 4 && total_money >= 25 )
				begin
					total_money = total_money - 25 ;
					$display( "milk out" ) ;
					error = 0 ;
				end
				
				else
				begin
					if( total_money >= 25 )
						$display( "Not enough money		total %d dollars	tea | coke | coffee | milk", total_money ) ;
					else if( total_money >= 20 )
						$display( "Not enough money		total %d dollars	tea | coke | coffee", total_money ) ;
					else if( total_money >= 15 )
						$display( "Not enough money		total %d dollars	tea | coke", total_money ) ;
					else if( total_money >= 10 )
						$display( "Not enough money		total %d dollars	tea", total_money ) ;
					error = 1 ;
				end
			end
		end
		
		S3:
		begin
			if( error == 0 )
			begin
				$display( "exchange %d dollars\n", total_money ) ;
				total_money = 0 ;
			end
		end
	endcase
		
end

always @ ( state or input_money or choice )		// change state
begin
	case( state )
		S0:
		begin
			if( total_money >= 10 )
				next_state = S1 ;
			else
				next_state = S0 ;
		end

		S1:
		begin
			if( input_money == 0 )
				next_state = S2 ;     // input end
			else
				next_state = S0 ;     // keep reading input
		end

		S2:
		begin
			if( choice == 0 )
				next_state = S3 ;     // choose end		
			else
				next_state = S2 ;     // read choose
		end

		S3:
		begin
			next_state = S0 ;     // next step
		end
	endcase
end

endmodule