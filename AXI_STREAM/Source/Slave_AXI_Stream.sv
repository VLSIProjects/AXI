`timescale 1ns / 1ps


module Slave_AXI_Stream #(parameter n = 4)
(
                    input logic aclk,
                    input logic  aresetn,
					output logic  tready,
					
                    input logic  tvalid,
                    
                    input logic  [8*n -1 : 0] tdata,
                    input logic  [  n -1 : 0] tstrb,
                    input logic  [  n -1 : 0] tkeep,
                    input logic  tlast,
                    input logic  TID,
                    input logic  TDEST,
                    input logic  TUSER,
                    
                    // testbench signals
                    input logic buf_available,
                    output logic  [8*n -1 : 0] data,
                    output logic d_valid,
                    output logic last_data
  );
  
  // TID, TDEST and TUSER are used for education purpose only. They are npt useful for us.
  
  // tready signal 
  assign tready = buf_available ? 1 : 0 ;
  
  // handshaking
  logic handshake ;
  
  assign handshake = tready && tvalid ;
  
  // data out signal
  always_ff @(posedge aclk or posedge aresetn)
    begin
        if (!aresetn)
            begin
                data   <= 0;
            end
        else if (handshake)
            begin
                data <= tdata ; 
            end   
    end
    
    always_ff @(posedge aclk or posedge aresetn)
    begin
        if (!aresetn)
            begin
                d_valid <= 0;
            end
        else if (handshake)
            begin
                d_valid <= 1 ;
            end 
       else    
            begin
                d_valid <= 0;
            end    
     end
  
  always_ff @(posedge aclk or posedge aresetn)
    begin
        if (!aresetn)
            begin
                last_data <= 0;
            end
        else
            begin
                last_data <= tdata;
            end
    end
    
            
endmodule
