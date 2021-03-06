//---------------------------------------------------------
//
//
//
//
//---------------------------------------------------------
class atto_base_test extends uvm_test;
    `uvm_component_utils(atto_base_test)

    virtual atto_if atto_if_m00;
    virtual axis_if axis_if_s00;

    atto_env_cfg    m_env_cfg  ; 
    atto_env        m_env      ; 

    string          m_file_i   ;
    string          m_file_o   ;  
    //        
    // constructor
    function new(string name="atto_base_test", uvm_component parent=null);
       super.new(name, parent);    
    endfunction
    
    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction
    
    // 
    extern virtual function void build_phase(uvm_phase phase);
endclass

//
// function :: build_phase
//
    function void atto_base_test::build_phase(uvm_phase phase);
        super.build_phase(phase);

        m_env = atto_env::type_id::create("m_env", this);

    //load cofig_db from top
        if(!uvm_config_db#(virtual atto_if)::get(this, "", "atto_m00", atto_if_m00))
            `uvm_fatal(get_full_name(), "cannot find atto_m00 vif")
        if(!uvm_config_db#(virtual axis_if)::get(this, "", "axis_s00", axis_if_s00))
            `uvm_fatal(get_full_name(), "cannot find axis_m00 vif")

        if(!uvm_config_db#(string)::get(this, "", "file_i", m_file_i))
            `uvm_fatal(get_full_name(), "cannot find m_file_i")        
        if(!uvm_config_db#(string)::get(this, "", "file_o", m_file_o))
            `uvm_fatal(get_full_name(), "cannot find m_file_o")           

    //m_env_cfg setting
        m_env_cfg = atto_env_cfg::type_id::create("m_env_cfg");

        m_env_cfg.atto_if_m00 = atto_if_m00;
        m_env_cfg.axis_if_s00 = axis_if_s00;
        m_env_cfg.m_file_i    = m_file_i   ;
        m_env_cfg.m_file_o    = m_file_o   ;

        uvm_config_db#(atto_env_cfg)::set(this, "m_env", "m_env_cfg", m_env_cfg);


        //m_env



    endfunction


