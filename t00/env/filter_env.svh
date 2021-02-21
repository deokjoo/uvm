//
//
//
//
//
class filter_env extends uvm_env;
    `uvm_component_utils(filter_env)

    filter_env_cfg m_env_cfg;


    function new(string name="filter_env", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    extern function void build_phase (uvm_phase phase);

endclass

//
//
function void filter_env::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if( !uvm_config_db#(filter_env_cfg)::get(this, "", "m_env_cfg", m_env_cfg) )
        `uvm_fatal(get_full_name(), "cannot get m_env_cfg");

    

endfunction





