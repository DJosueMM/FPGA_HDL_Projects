package spi_pkg; 
    
    //Modelado del registro de control
    typedef struct packed {

        logic [5 : 0] nc_b;
        logic [9 : 0] n_rx_end;
        logic [2 : 0] nc_a;
        logic [8 : 0] n_tx_end;
        logic all_0s;
        logic all_1s;
        logic cs_ctrl;
        logic send;

    } palabra_control;


endpackage
