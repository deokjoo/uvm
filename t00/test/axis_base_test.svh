//
//
//
//
//
//

class filter_base_test extends uvm_test;
    `uvm_component_utils(filter_base_test)

     filter_env_cfg m_env_cfg; 
     filter_env     m_env    ; 

    //        
    // constructor
    function new(string name="filter_base_test", uvm_component parent=null);
       super.new(name, parent);    
    endfunction

    //
    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction

    extern function void build_phase(uvm_phase phase);
endclass


//
//
//
function void filter_base_test::build_phase(uvm_phase phase);
    super.build_phase(phase);

    //m_env_cfg setting
    m_env_cfg = filter_env_cfg::type_id::create("m_env_cfg");

    uvm_config_db#(filter_env_cfg)::set(this, "*", "m_env_cfg", m_env_cfg);


    //m_env
    m_env = filter00_env::type_id::create("m_env", this);



endfunction


