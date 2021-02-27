//---------------------------------------------------------
//
//
//
//---------------------------------------------------------
class axis_monitor extends uvm_monitor;
    `uvm_component_utils(axis_monitor)

    axis_agent_cfg m_cfg;
    virtual axis_if _if ;
    
    uvm_analysis_port #(axis_pixel) m_analysys_port;

    //
    function new(string name="axis_monitor", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    //
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
endclass

//
//
//
function void axis_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if( !uvm_config_db#(axis_agent_cfg)::get(this, "", "cfg", m_cfg) )
        `uvm_fatal(get_full_name(), "cannot find cfg")

    _if = m_cfg._if;
    
    m_analysys_port = new("m_analysys_port", this);

endfunction

//
//
//
task axis_monitor::run_phase(uvm_phase phase);
    axis_pixel pixel  = new();
    
    super.run_phase(phase);

    forever begin
        @(posedge _if.cb_slave);

        if(_if.cb_slave.axis_tvalid == 1) begin
            pixel.v = _if.cb_slave.axis_tdata;

            m_analysys_port.write(pixel);

            // `uvm_info(get_full_name(), $sformatf("%0dns : MON", $time), UVM_LOW);
        end
    end

endtask