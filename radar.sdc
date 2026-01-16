create_clock -name MAX10_CLK1_50 -period 20.000 -waveform {10 20} [get_ports {MAX10_CLK1_50}]

derive_clock_uncertainty
