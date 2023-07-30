`timescale 1ns / 1ps


module Master_AXI_Stream #(parameter n = 4)
(
                    input logic aclk,
                    input logic  aresetn,
                    output logic  tvalid,
                    input logic  tready,
                    output logic  [8*n -1 : 0] tdata,
                    output logic  [  n -1 : 0] tstrb,
                    output logic  [  n -1 : 0] tkeep,
                    output logic  tlast,
                    output logic  TID,
                    output logic  TDEST,
                    output logic  TUSER,
                    
                    // testbench signals
                    input logic  [8*n -1 : 0] data,
                    input logic  send,
                    input logic  last,
					input logic [1:0] data_address,
                    output logic  finish
                    
    );
    
   assign TID = 1;
   assign TDEST = 1;
   assign TUSER = 1;
   
// handshaking
  logic handshake ;
  
  assign handshake = tready && tvalid ;
  
  // input data
  logic [1:0] count ;
    always_ff@( posedge aclk or negedge aresetn )
			if(!aresetn)
			     count <= 0;
			else if(count == 2)
			     count <= count ;
			else count <= count + 1;
			
			 

  
// output data 
	always_ff@( posedge aclk or negedge aresetn )
		begin
			if(!aresetn)
				tdata <= 0;
			else if (count == 1)
			     tdata <= data ;
			else if(handshake)
				tdata <= data ;
				
				
		end
 
// valid output
	always_ff@(posedge aclk or negedge aresetn)
		begin
			if(!aresetn)
				tvalid <= 0 ;
			else if (send)
				tvalid <= 1 ;
				
		end

 
 // strobe signals and keep signals		data_address
	always_ff@(posedge aclk or negedge aresetn)
		begin
			if(!aresetn)
				begin
					tstrb <= 0;
					tkeep <= 0;
				end
			else case(data_address)
			2'b00:	// null byte
				begin
					tstrb <= 0;
					tkeep <= 0;
				end
				
			2'b01:	// Reserved
				begin
					tstrb <= 0;
					tkeep <= 4'hf;
				end
				
			2'b10:	// Position (Address) byte
				begin
					tstrb <= 4'hf;
					tkeep <= 0;
				end
				
			2'b11:	// Data byte
				begin
					tstrb <= 4'hf;
					tkeep <= 4'hf;
				end
			endcase	

		end

	// tlast output
	always_ff@(posedge aclk or negedge aresetn)
		begin
			if(!aresetn)
				tlast <= 0 ;
			else if (send)
				tlast <= last ;
		end
 
 assign finish = last ? 1 : 0 ;
 
endmodule
