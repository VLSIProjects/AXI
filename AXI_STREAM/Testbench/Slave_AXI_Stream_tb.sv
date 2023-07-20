`timescale 1ns / 1ps


module Slave_AXI_Stream_tb(  );
parameter n = 4 ;

logic aclk;
logic  aresetn;
logic  tready;
logic  tvalid;
logic  [8*n -1 : 0] tdata;
logic  [  n -1 : 0] tstrb;
logic  [  n -1 : 0] tkeep;
logic  tlast;
logic  TID;
logic  TDEST;
logic  TUSER;
// testbench signals
logic buf_available;
logic  [8*n -1 : 0] data;
logic d_valid;
logic last_data;

Slave_AXI_Stream u_Slave_AXI_Stream (
     					.aclk 			( aclk 			 )  ,
                        .aresetn 		( aresetn 		 )  ,
    					.tready 		( tready 			 )  ,
                        .tvalid 		( tvalid 			 )  ,
                        .tdata 			( tdata 			 )  ,
                        .tstrb 			( tstrb 			 )  ,
                        .tkeep 			( tkeep 			 )  ,
                        .tlast 			( tlast 			 )  ,
                        .TID 			( TID 			 )  ,
                        .TDEST 			( TDEST 			 )  ,
                        .TUSER 			( TUSER 			 )  ,
                        .buf_available 	( buf_available 	 )  ,
                        .data 			( data 			 )  ,
                        .d_valid 		( d_valid 		 )  ,
                        .last_data 		( last_data 		 )

);

 initial aclk = 0;
 
 always #5 aclk = ~aclk ;
 
 initial
    begin
        aresetn = 0 ;
        buf_available = 0;
    #45 aresetn = 1 ;
    
    #55 buf_available = 1;
    
    #105 buf_available = 0;
    
    #55 buf_available = 1;
    
    end 


  always_ff@(posedge aclk or negedge aresetn)
			if(!aresetn)
			 begin
			     tdata <= 0 ;
			     tvalid <= 0 ; 
			 end    
			else if (tready)
			begin 
			     tdata <= tdata + 1 ;
			     tvalid <= 1 ;      
			end
			else 
			begin 
			     tdata <= 1 ;
			     tvalid <= 1 ;      
			end
			
			
			
  assign tlast = tdata == 32 ? 1 : 0 ;













endmodule
