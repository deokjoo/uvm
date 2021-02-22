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

    extern virtual function void build_phase (uvm_phase phase);

endclass

//
//
function void filter_env::build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info(get_full_name(), "HI", UVM_LOW)

    if( !uvm_config_db#(filter_env_cfg)::get(this, "", "m_env_cfg", m_env_cfg) )
        `uvm_fatal(get_full_name(), "cannot get m_env_cfg");

    

endfunction


//-----------------------------------------------------------------------------
// 
//
//-----------------------------------------------------------------------------
class filter00_env extends filter_env;
    `uvm_component_utils(filter00_env)

    axis_agent_cfg  m_axis_m00_cfg;
    axis_agent_cfg  m_axis_s00_cfg;
    axis_agent      m_axis_m00    ;
    axis_agent      m_axis_s00    ;
    axis_scoreboard m_axis_scbd   ;

    function new(string name="filter00_env", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase (uvm_phase phase);

endclass

//
//
function void filter00_env::build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info(get_full_name(), "HI", UVM_LOW)

    //Set agent configuration
    m_axis_m00_cfg = axis_agent_cfg::type_id::create("m_axis_m00_cfg", this);
    uvm_config_db#(axis_agent_cfg)::set(this,"m_axis_m00", "cfg", m_axis_m00_cfg);
    
    //Set agent configuration
    m_axis_s00_cfg = axis_agent_cfg::type_id::create("m_axis_s00_cfg", this);
    uvm_config_db#(axis_agent_cfg)::set(this,"m_axis_s00", "cfg", m_axis_s00_cfg);
    
    //
    m_axis_m00 = axis_agent::type_id::create("m_axis_m00", this);
    m_axis_s00 = axis_agent::type_id::create("m_axis_s00", this);

    m_axis_scbd= axis_scoreboard::type_id::create("m_axis_scbd", this);


endfunction
























