//
//
//
//
//

class filter_env_cfg extends uvm_object;
    `uvm_object_utils(filter_env_cfg)


    virtual axis_if axis_if_m00;
    virtual axis_if axis_if_s00;

    //
    function new(string name="filter_env_cfg");
        super.new(name);
    endfunction

endclass

//
//

