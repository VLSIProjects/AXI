`timescale 1ns / 1ps

module Master_AXI_Stream_tb( );
    parameter n = 4;
                     logic aclk;
                     logic  aresetn;
                     logic  tvalid;
                     logic  tready;
                     logic  [8*n -1 : 0] tdata;
                     logic  [  n -1 : 0] tstrb;
                     logic  [  n -1 : 0] tkeep;
                     logic  tlast;
                     logic  TID;
                     logic  TDEST;
                     logic  TUSER;
                    
                    // testbench signals
                     logic  [8*n -1 : 0] data;
                     logic  send;
                     logic  last;
					 logic [1:0] data_address;
                     logic  finish ;   
    
 Master_AXI_Stream u_Master_axis
(
                      .aclk 		( aclk 			 ) ,
                      .aresetn 		( aresetn 		 ) ,
                      .tvalid 		( tvalid 		 ) ,
                      .tready 		( tready 		 ) ,
                      .tdata 		( tdata 		 ) ,
                      .tstrb 		( tstrb 		 ) ,
                      .tkeep 		( tkeep 		 ) ,
                      .tlast 		( tlast 		 ) ,
                      .TID 			( TID 			 ) ,
                      .TDEST 		( TDEST 		 ) ,
                      .TUSER 		( TUSER 		 ) ,
                      .data 		( data 			 ) ,
                      .send 		( send 			 ) ,
                      .last 		( last 			 ) ,
					  .data_address ( data_address   ) ,
                      .finish 		( finish 		 )
                    
    );   
    
 initial aclk = 0;
 
 always #5 aclk = ~aclk ;
 
 initial
    begin
        aresetn = 0 ;
        send    = 0;
    #25 aresetn = 1 ;
        data_address = 3;
    #20 send = 1 ;
    #300 data_address = 2;
    end   
    
  always_ff@(posedge aclk or negedge aresetn)
			if(!aresetn)
			     data <= 0 ;
			else
			     data <= data + 1 ;
			          
			
  assign last = data == 32 ? 1 : 0 ;
  
  
    
endmodule
