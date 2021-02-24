//
//
//
//
//

class filter_env_cfg extends uvm_object;
    `uvm_object_utils(filter_env_cfg)
    
    virtual axis_if axis_if_m00;
    virtual axis_if axis_if_s00;
    
    string m_file_i;
    string m_file_o;
    
    //
    function new(string name="filter_env_cfg");
        super.new(name);
    endfunction

endclass

//
//

