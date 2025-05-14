module Up_Dn_Counter (

input   wire [4:0]  IN,
input   wire        Load,
input   wire        Up,Down,
input   wire        clk,
output  reg  [4:0]  counter,
output  reg         High,Low
);

 always @ (posedge clk)
   begin  
      if (Load)
        begin 
          counter <= IN;
        end 

      else if (Down && !Low) 
        begin 
          counter <= counter - 5'b00001;
        end 

      else if (Up && !High && !Down)
        begin 
          counter <= counter + 5'b00001;
        end 
    end 


 always @ (*)
   begin 
     if ( counter == 5'b0 )
       begin 
         Low  = 1'b1;
       end

     else if ( counter == 5'b11111 )
       begin 
         High = 1'b1;
       end

     else 
       begin 
         High = 1'b0;
         Low  = 1'b0;
       end
   end

endmodule 