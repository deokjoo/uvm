//
//
//
//
//

class atto_env_cfg extends uvm_object;
    `uvm_object_utils(atto_env_cfg)
    
    virtual atto_if atto_if_m00;
    virtual axis_if axis_if_s00;
    
    string m_file_i;
    string m_file_o;
    
    //
    function new(string name="atto_env_cfg");
        super.new(name);
    endfunction

endclass

//
//

