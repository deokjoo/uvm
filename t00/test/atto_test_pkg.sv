//
//
//
//
//
//
package atto_test_pkg;
    `include "uvm_macros.svh"
    
    import uvm_pkg::*;

//utils
    `include "utils.svh"

//sequnce item
    `include "atto_pixel.svh"
    `include "axis_pixel.svh"
    `include "frame_seq_item.svh"
//agent atto and axis
    `include "atto_driver.svh"
    `include "atto_monitor.svh"
    `include "atto_agent_cfg.svh"
    `include "atto_agent.svh"    
    
    `include "axis_driver.svh"
    `include "axis_monitor.svh"
    `include "axis_agent_cfg.svh"
    `include "axis_agent.svh"
//sequence..
    `include "frame_seq.svh"
    `include "filter_seq.svh"
    `include "filter_sqr.svh"
//env    
    `include "axis_scoreboard.svh"    
    `include "atto_env_cfg.svh"
    `include "atto_env.svh"
//test
    `include "atto_base_test.svh"

endpackage
