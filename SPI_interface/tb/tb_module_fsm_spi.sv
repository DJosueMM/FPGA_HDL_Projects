
module tb_module_fsm_spi;
    
    import spi_pkg::*;
    
    //Entradas
    logic clk_i;
    logic rst_i;

    logic pos_edge_i;
    logic neg_edge_i;

    palabra_control palabra_control_i;
    
    //Salidas
    logic en_sclk_o;
    logic en_shift_tx_o;
    logic en_shift_rx_o;
    logic en_load_o;

    logic hold_ctrl_o;

    logic we2_data_o;
    logic we2_control_o;

    logic cs_o;  

    logic [1:0] addr2_o;
    logic send_o;
    logic [1:0] mux_all_01_sel;
    logic [9:0] n_rx_end_o;

    logic clk_100kHz;

    module_fsm_spi DUT (
        .clk_i              (clk_i),
        .rst_i              (rst_i),
        .pos_edge_i         (pos_edge_i),
        .neg_edge_i         (neg_edge_i),
        .palabra_control_i  (palabra_control_i),
        .en_sclk_o          (en_sclk_o),
        .en_shift_tx_o      (en_shift_tx_o),
        .en_shift_rx_o      (en_shift_rx_o),
        .en_load_o          (en_load_o),
        .hold_ctrl_o        (hold_ctrl_o),
        .we2_data_o         (we2_data_o),
        .we2_control_o      (we2_control_o),
        .cs_o               (cs_o),
        .addr2_o            (addr2_o),
        .send_o             (send_o),
        .mux_all_01_sel     (mux_all_01_sel),
        .n_rx_end_o         (n_rx_end_o)
    );

    reloj_divisor DUT2 (
        .clk_10MHz  (clk_i),
        .rst_i      (rst_i),
        .en_sclk_i  (en_sclk_o), 
        .clk_100kHz (clk_100kHz),
        .pos_edge   (pos_edge_i),
        .neg_edge   (neg_edge_i)
    );
    

    initial   clk_i = 0;
    always #50 clk_i = ~clk_i;
    

    initial begin
    
        clk_i      = 0;
        rst_i      = 0;       
        palabra_control_i = '0;
         
        #10000
        rst_i = 1;

        #10
        palabra_control_i.send    = 1'b1;
        palabra_control_i.cs_ctrl = 1'b1;
        palabra_control_i.n_tx_end = 1;
        palabra_control_i.all_1s = 1'b1;

  
        #1000
        #105
        palabra_control_i.send    = 1'b0;
    end
endmodule