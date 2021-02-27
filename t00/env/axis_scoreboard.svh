

//
//
//
//
//
class file_reader extends uvm_object;
    `uvm_object_utils(frame_reader)

    //
    int    m_fd   = 0;
    
    string m_prefix;
    int    m_w     ;
    int    m_h     ;
    int    m_nr    ;

    int    m_c_seq = 0;
    int    m_c_w   = 0;
    int    m_c_h   = 0; 
    //
    function new(string name="file_reader");
        super.new(name);
    endfunction

    //
    function int open(string file_info);
        assert ($sscanf(file_info, "%s %d %d %d", m_prefix, m_w, m_h, m_nr) == 4);
    endfunction

    function void close();
        if(m_fd != 0)
            $fclose(m_fd);
        m_fd = 0;
    endfunction

    //
    function int read();
        int pixel;

        //open next files
        if(m_fd == 0)begin
            string name = $sformatf("%s_%02d.txt", m_prefix,m_c_seq);
            
            m_fd   = $fopen(name,"r");
            if(!m_fd) begin
                `uvm_fatal(get_full_name(), "file open failed")
                return 0;
            end 
        end

        assert($fscanf(m_fd, "%h", pixel) == 1);

        m_c_w++;
        if(m_c_w >= m_w) begin
            m_c_w = 0;
            m_c_h++;
            if(m_c_h>=m_h)begin
                m_c_h = 0;
                m_c_seq++;

                close();
            end

        end

        return pixel;        

    endfunction



endclass

//---------------------------------------------------------
//
//
//---------------------------------------------------------
class axis_scbd extends uvm_scoreboard;
    `uvm_component_utils(axis_scbd)

    string m_cfg;
    file_reader m_file_reader;
    uvm_analysis_imp #(axis_pixel, axis_scbd) m_analysis_imp;
    //
    function new(string name="axis_scbd", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    //
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
    extern virtual function void write(axis_pixel data);

endclass

//
//
function void axis_scbd::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if( !uvm_config_db#(string)::get(this, "", "cfg", m_cfg) )
        `uvm_fatal(get_full_name(), "cannot find cfg")

    m_analysis_imp = new("m_analysis_imp", this);
    m_file_reader  = new();
    m_file_reader.open(m_cfg);

endfunction

//
//
function void axis_scbd::connect_phase(uvm_phase phase);
    super.connect_phase(phase);


endfunction
//
//
function void axis_scbd::write(axis_pixel data);
    int pixel_pred = m_file_reader.read();

    if(pixel_pred != data.v) begin
        `uvm_info(get_full_name(), $sformatf("[%02t] %04h : %04h", $time, pixel_pred, data.v),UVM_LOW);
    end

endfunction

