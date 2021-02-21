//
//
//
//
//

class axis_agent extends uvm_agent;
    `uvm_component_utils(axis_agent)

    axis_agent_cfg m_cfg; 

    function new (string name="axis_agent", uvm_component parent=null);
        super.new(name, parent);
    endfunction


    extern function void build_phase(uvm_phase phase);

endclass

//
//
virtual function void axis_agent::build_phase (uvm_phase phase);
    super.build_phase(phase)

    if( !uvm_config_db#(filter_env_cfg)::get(this, "", "cfg", m_cfg) )
        `uvm_fatal(get_full_name(), "cannot find m_cfg")

endfunction

