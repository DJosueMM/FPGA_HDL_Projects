module top_module_spi 

    import spi_pkg ::*;
    (
    
    input logic            clk_pi,

    input logic            wr_pi, //boton
    input logic            reg_sel_pi,  //sw
    input logic  [12 : 0]  entrada_pi,  //sw
    input logic  [1  : 0]  addr_pi,     //sw

    output logic [15 : 0]  leds_po,     //Salida de datos
    
    input logic            miso_pi,     //Puerto serial
    output logic           mosi_po,     //Puerto serial   
    output logic           sclk_po,
    output logic           ss_po
);

 
    logic clk_10MHz;
    logic rst;
    logic wr_i;
    logic wr1_d;
    logic wr1_c;
    logic wr2_d;
    logic wr2_c;
    logic [31 : 0] out_1_d;
    logic [31 : 0] in_1_d;
    logic [7 : 0]  out_2_d;
    logic [7 : 0]  in_2_d;
    logic [31 : 0] out_c;
    
    logic en_sclk;
    logic en_load;
    logic en_shift_tx;
    logic en_shift_rx;
    logic send_clear;
    logic [9 : 0] n_rx_clear;
    
    logic [1  : 0] addr_2;
    logic hold_ctrl;
    
    logic [7  : 0] data_for_tx;
    logic [1 : 0] mux_all_01_sel;
    
    logic pos_edge;
    logic neg_edge;

    logic [31 : 0] salida_o;
    
    ///Para defensa de SPI sola
    //logic [31 : 0] data_i;
    
    //assign data_i [7 : 0] = entrada_pi [7 : 0];
        
    assign leds_po [12 : 0] = salida_o [12 : 0];
    assign leds_po [15 : 13] = salida_o [25 : 16];
    
    clk_wiz_0 PLL( 
        .clk_out1   (clk_10MHz),           
        .locked     (rst),
        .clk_in1    (clk_pi)
    );
    
    logic wr_pulse;
    module_nivel_pulso ENTRADA_HUMANA(

    //entradas
    .clk_i (clk_10MHz),
    .rst_i (rst),
    .p_i   (wr_pi),
    
    //salidas 
    .pulso_o (wr_pulse)
    );
    
    reloj_divisor SCLK (
        .clk_10MHz(clk_10MHz),
        .rst_i(rst),
        .en_sclk_i(en_sclk),
        .clk_100kHz(sclk_po),
        .pos_edge(pos_edge),
        .neg_edge(neg_edge)
    );

    module_dmux_1_2 DMUX_WE (
        .wr_i           (wr_pulse),
        .reg_sel_i      (reg_sel_pi),
        .wr1_control_o  (wr1_c),
        .wr1_datos_o    (wr1_d)
    );
    
    module_mux_2_1 MUX_SALIDA (
        .mux_sel       (reg_sel_pi),
        .control_i     (out_c),
        .datos_i       (out_1_d),
        .salida_o      (salida_o)
    );
    
    module_mux_3_1 MUX (
        .sel    (mux_all_01_sel),
        .data_i (out_2_d),
        .data_o (data_for_tx)
    );

    module_fsm_spi FSM (
        .clk_i              (clk_10MHz),
        .rst_i              (rst),
        .pos_edge_i         (pos_edge),
        .neg_edge_i         (neg_edge),
        .palabra_control_i  (out_c),
        .en_sclk_o          (en_sclk),
        .en_shift_tx_o      (en_shift_tx),
        .en_shift_rx_o      (en_shift_rx),
        .en_load_o          (en_load),
        .hold_ctrl_o        (hold_ctrl),
        .we2_data_o         (wr2_d),
        .we2_control_o      (wr2_c),
        .cs_o               (ss_po),
        .addr2_o            (addr_2),
        .send_o             (send_clear),
        .mux_all_01_sel     (mux_all_01_sel),
        .n_rx_end_o         (n_rx_clear)
    );

    registro_control_spi RC (
        .data_1_i       (entrada_pi),
        .n_rx_end_i     (n_rx_clear),
        .clk_i          (clk_10MHz),
        .rst_i          (rst),
        .send_clear_i   (send_clear),
        .wr_1_i         (wr1_c),
        .wr_2_i         (wr2_c),
        .data_o         (out_c)
    );
 
    module_registro_datos_spi RD (
        .clk_i          (clk_10MHz),
        .rst_i          (rst),
        .wr1_i          (wr1_d),
        .wr2_i          (wr2_d),
        .hold_ctrl_i    (hold_ctrl),
        .addr_1_i       (addr_pi),
        .addr_2_i       (addr_2),
        .data_in1_i     (entrada_pi),
        .data_in2_i     (in_2_d),
        .data1_o        (out_1_d),
        .data2_o        (out_2_d)
    );
    
    module_rx_shift_reg_spi RX_SHIFT (
        .clk_i      (clk_10MHz),
        .rst_i      (rst),
        .shift_en_i (en_shift_rx),
        .data_i     (miso_pi),
        .data_o     (in_2_d)
    );

    module_tx_shift_reg_spi TX_SHIFT (
        .clk_i      (clk_10MHz),
        .rst_i      (rst),
        .load_en_i  (en_load),
        .shift_en_i (en_shift_tx),
        .data_i     (data_for_tx),
        .data_o     (mosi_po)
    );


endmodule