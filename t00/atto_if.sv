//
//
//
//
//
//

`timescale 1ns/1ps


interface atto_if #(
    parameter DATA_WIDTH    = 8             ,
    parameter KEEP_ENABLE   = (DATA_WIDTH>8),
    parameter KEEP_WIDTH    = (DATA_WIDTH/8),  
    parameter ID_ENABLE     = 0             ,
    parameter ID_WIDTH      = 8             ,
    parameter DEST_ENABLE   = 0             ,
    parameter DEST_WIDTH    = 8             ,
    parameter USER_ENABLE   = 1             ,
    parameter USER_WIDTH    = 1
)
(input aclk);

    logic  [DATA_WIDTH-1:0]  axis_tdata  ;
    logic  [KEEP_WIDTH-1:0]  axis_tkeep  ;
    logic                    axis_tvalid ;
    logic                    axis_tready ;
    logic                    axis_tlast  ;
    logic  [ID_WIDTH-1  :0]  axis_tid    ;
    logic  [DEST_WIDTH-1:0]  axis_tdest  ;
    logic  [USER_WIDTH-1:0]  axis_tuser  ;

    //
    // clocking..
    //
    clocking cb_master @(posedge aclk);
        default input #1step;
        
        input  axis_tready;
        output axis_tdata ;
        output axis_tvalid;
        output axis_tlast ;
        output axis_tuser ;
    
    endclocking
    //
    clocking cb_slave @(posedge aclk);
        default input #1step;
        
        output  axis_tready;
        input   axis_tdata ;
        input   axis_tvalid;
        input   axis_tlast ;
        input   axis_tuser ;
    
    endclocking

    //
    // modport
    //
    modport master (clocking cb_master);
    modport slave  (clocking cb_slave );



endinterface