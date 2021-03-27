//---------------------------------------------------------
//
//
//
//---------------------------------------------------------
class frame_reader extends uvm_object;
    `uvm_object_utils(frame_reader)

    int             m_fd  ;
    frame_seq_item  m_item; 

    function new(string name="frame_reader");
        super.new(name);
    endfunction

    //
    function int open(frame_seq_item item);
        `uvm_info("DRV", $sformatf("open file: %0d %s", $time, item.m_input_file), UVM_LOW);        
       
        m_item = item;
        m_fd   = $fopen(item.m_input_file,"r");
        
        if(!m_fd) begin
            `uvm_fatal(get_full_name(), "file open failed")
            return 0;
        end

        return 1;

    endfunction

    function int close();
        $fclose(m_fd);
    endfunction

    function int read();
        int pixel;
        assert($fscanf(m_fd, "%h", pixel) == 1);        
        return pixel;
    endfunction 

endclass