
//
//
//
//
//
class axis_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(axis_scoreboard)

    uvm_analysis_imp #(axis_pixel) m_analysis_imp;


    function new(string name="axis_scoreboard", uvm_componet parent=null);
        super.new(name, parent)
    endfunction

    //
    extern virtual function void build_phase(uvm_phase phase);

endclass

//
function void axis_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);

    m_imp = new("m_analysis_imp", this);

endfunction

