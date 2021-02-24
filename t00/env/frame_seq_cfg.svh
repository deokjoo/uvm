//---------------------------------------------------------
//
//
//
//---------------------------------------------------------

class frame_seq_cfg extends uvm_object;
    `uvm_object_utils(frame_seq_cfg)

    string m_file;
    int    m_seqs;
    int    m_w   ;
    int    m_h   ;


    function new(string name="frame_seq_cfg");
        super.new(name);
    endfunction

endclass

//
//
