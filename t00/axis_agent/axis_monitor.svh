//
//
//
//
//

class axis_monitor extends uvm_monitor;
    `uvm_component_utils(axis_monitor)

    uvm_analysis_port#(axis_pixel) m_analysys_port;


    function new(string name="axis_monitor", uvm_component parent=null)
        super.new(name, parent);
    endfunction

    //

    extern virtual function void build_phase(uvm_phase phase);

endclass

//
function void axis_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);

    m_port = new("m_analysys_port", this);

endfunction

