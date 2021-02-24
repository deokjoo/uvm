//---------------------------------------------------------
//
//
//
//---------------------------------------------------------

class frame_seq extends uvm_sequence_item;
    `uvm_object_utils(frame_seq)

    //
    str m_input_file;
    int m_w;
    int m_h;

    // 
    virtual function string convert2str();
        return $sformatf("%s", m_input_file);
    endfunction

    function new(string name="frame_seq");
        super.new(name);
    endfunction

    //

endclass