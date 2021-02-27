
//
//
//
//
//
class axis_scbd extends uvm_scoreboard;
    `uvm_component_utils(axis_scbd)

    uvm_analysis_imp #(axis_pixel, axis_scbd) m_analysis_imp;

    function new(string name="axis_scbd", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    //
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void write(axis_pixel data);

endclass


//
//
function void axis_scbd::build_phase(uvm_phase phase);
   super.build_phase(phase);

   m_analysis_imp = new("m_analysis_imp", this);

endfunction

//
function void axis_scbd::write(axis_pixel data);
    `uvm_info(get_full_name(), $sformatf("%04h", data.v),UVM_LOW);

endfunction

