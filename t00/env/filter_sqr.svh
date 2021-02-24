
//---------------------------------------------------------
//
//
//---------------------------------------------------------
class filter_sequencer extends uvm_sequencer;
    `uvm_component_utils(filter_sequencer)

    uvm_sequencer#(frame_seq_item)  m_axis_seqr;

    //
    function new(string name="filter_sequencer", uvm_component parent=null)
        super.new(name, parent);
    endfunction


endclass
