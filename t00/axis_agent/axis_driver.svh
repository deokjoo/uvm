//---------------------------------------------------------
//
//
//
//---------------------------------------------------------

class axis_driver extends uvm_driver #(axis_pixel);
    `uvm_component_utils(axis_driver);
        
    axis_agent_cfg m_cfg;
    virtual axis_if _if ;

    function  new(string name="axis_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    //
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
    extern virtual task drive_item(axis_pixel item);

endclass

//
//
function void axis_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if( !uvm_config_db#(axis_agent_cfg)::get(this, "", "cfg", m_cfg) )
        `uvm_fatal(get_full_name(), "cannot find cfg")

    _if = m_cfg._if;

endfunction

//
//
task axis_driver::run_phase(uvm_phase phase);
    axis_pixel data;
        
    super.run_phase(phase);
    
    forever begin
        seq_item_port.get_next_item(data);
        drive_item(data);
        seq_item_port.item_done();
    end


endtask

//
task axis_driver::drive_item(axis_pixel item);

    repeat(10) @(posedge _if.ACLK);
    `uvm_info("DRV", $sformatf("drive item : %s %s", $time, item.convert2str()), UVM_LOW);

endtask
