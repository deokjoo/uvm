
//
//
//
//
//

class axis_agent_cfg extends uvm_object:
    `uvm_object_utils(axis_agent_cfg)

    function new(string name="axis_agent_cfg");
        super.new(name)
    endfunction

    extern virtual function void build_phase (uvm_phase phase);

endclass

//
//
virtual function void axis_agent_cfg::build_phase (uvm_phase phase);
    super.build_phase(phase)

    if( !uvm_config_db#(filter_env_cfg)::get(this, "", "cfg", m_env_cfg) )
        `uvm_fatal(get_full_name(), "cannot get m_env_cfg")



endfunction



