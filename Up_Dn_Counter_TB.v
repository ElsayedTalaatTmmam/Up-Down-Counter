`timescale 1ns/1ps

module Up_Dn_Counter_TB ();

// Declaretion
  reg  [4:0]  IN_TB;
  reg         Load_TB;
  reg         Up_TB;
  reg         Down_TB;
  reg         clk_TB;
  wire [4:0]  counter_TB;
  wire        High_TB;
  wire        Low_TB;

// Instantiation
 Up_Dn_Counter DUT (
  .IN     (IN_TB),
  .Load   (Load_TB),
  .Up     (Up_TB),
  .Down   (Down_TB),
  .clk    (clk_TB),
  .counter(counter_TB),
  .High   (High_TB),
  .Low    (Low_TB)
  );

// clock generator
always #5 clk_TB=~clk_TB;
// Initial Block
 initial 
  begin 
   $dumpfile("Up_Down_Counter_TB.cdv");
   $dumpvars;
   clk_TB  = 1'b0;
   Up_TB   = 1'b0;
   Down_TB = 1'b0;
   Load_TB = 1'b0;
   IN_TB   = 5'b00101;

   $display (" Test Case 1 "); // load
   #3  //3
   Load_TB = 1'b1;
   #7  //10
   if ( counter_TB == 5'b00101)
     $display (" Test Case 1 : is passed ");
   else $display (" Test Case 1 : is faild ");
//////////////////////////////////////////////////////////////////////

   $display (" Test Case 2 "); // Load has highest priority
   #3  //13
   Load_TB = 1'b1;
   Up_TB   = 1'b1;
   Down_TB = 1'b1;
   #7  //20
   if ( counter_TB == 5'b00101)
     $display (" Test Case 2 : is passed ");
   else $display (" Test Case 2 : is faild ");
//////////////////////////////////////////////////////////////////////

   $display (" Test Case 3 "); // down
   #3  //23
   Load_TB = 1'b0;
   Up_TB   = 1'b0;
   Down_TB = 1'b1;
   #17  //40 counter=5-2=3
   if ( counter_TB == 5'b00011)
     $display (" Test Case 3 : is passed ");
   else $display (" Test Case 3 : is faild ");
//////////////////////////////////////////////////////////////////////

   $display (" Test Case 4 "); // Down has higher priority than up
   #3  //43
   Load_TB = 1'b0;
   Up_TB   = 1'b1;
   Down_TB = 1'b1;
   #37  //80 counter=3-2=1
   if ( counter_TB == 5'b00000)
     $display (" Test Case 4 : is passed ");
   else $display (" Test Case 4 : is faild ");
//////////////////////////////////////////////////////////////////////

  $display (" Test Case 5 "); // check not change
   #3  //83
   Load_TB = 1'b0;
   Up_TB   = 1'b0;
   Down_TB = 1'b0;
   #17  // 100
   if ( counter_TB == 5'b00000)
     $display (" Test Case 5 : is passed ");
   else $display (" Test Case 5 : is faild ");
//////////////////////////////////////////////////////////////////////

   $display (" Test Case 6 "); // up
   #3  //103
   Load_TB = 1'b0;
   Up_TB   = 1'b1;
   Down_TB = 1'b0;
   #77 //180  counter=0+8=8
   if ( counter_TB == 5'b01000)
     $display (" Test Case 6 : is passed ");
   else $display (" Test Case 6 : is faild ");
 //////////////////////////////////////////////////////////////////////

   #200  
   $finish ;

  end
endmodule 
