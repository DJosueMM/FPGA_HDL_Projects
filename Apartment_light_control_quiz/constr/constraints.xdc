## Clock signal
##Bank = 35, Pin name = IO_L12P_T1_MRCC_35,					Sch name = CLK100MHZ
set_property PACKAGE_PIN E3 [get_ports clk_pi]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk_pi]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk_pi]

##Buttons
set_property PACKAGE_PIN T16 [get_ports p1_pi]						
	set_property IOSTANDARD LVCMOS33 [get_ports p1_pi]
##Bank = 14, Pin name = IO_25_14,							Sch name = BTNR
set_property PACKAGE_PIN R10 [get_ports p2_pi]						
	set_property IOSTANDARD LVCMOS33 [get_ports p2_pi]

set_property PACKAGE_PIN T8 [get_ports {b_po[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {b_po[0]}]

set_property PACKAGE_PIN V9 [get_ports {b_po[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {b_po[1]}]

set_property PACKAGE_PIN R8 [get_ports {b_po[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {b_po[2]}]