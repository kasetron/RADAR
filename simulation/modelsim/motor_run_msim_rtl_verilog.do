transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar {C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar/sensor.v}
vlog -vlog01compat -work work +incdir+C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar {C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar/trigger.v}
vlog -vlog01compat -work work +incdir+C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar {C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar/echo.v}
vlog -vlog01compat -work work +incdir+C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar {C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar/bin2bcd.v}
vlog -vlog01compat -work work +incdir+C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar {C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar/mux7seg.v}
vlog -vlog01compat -work work +incdir+C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar {C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar/SR.v}
vlog -vlog01compat -work work +incdir+C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar {C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar/filtro_mediano.v}
vlog -vlog01compat -work work +incdir+C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar {C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar/enabler.v}

vlog -vlog01compat -work work +incdir+C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar {C:/Users/aless/Documents/ALESSIO/Laurea_Magistrale/3_PSD/Codice/5_radar/sensor_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  sensor_tb

add wave *
view structure
view signals
run -all
