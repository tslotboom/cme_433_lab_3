onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /microprocessor_tb/clk
add wave -noupdate /microprocessor_tb/reset
add wave -noupdate /microprocessor_tb/i_pins
add wave -noupdate /microprocessor_tb/o_reg
add wave -noupdate /microprocessor_tb/ir
add wave -noupdate /microprocessor_tb/pm_data
add wave -noupdate /microprocessor_tb/pm_address
add wave -noupdate /microprocessor_tb/pc
add wave -noupdate /microprocessor_tb/from_PS
add wave -noupdate /microprocessor_tb/data_pipe
add wave -noupdate /microprocessor_tb/pm_address_out
add wave -noupdate /microprocessor_tb/address_pipe
add wave -noupdate /microprocessor_tb/pm_data_out
add wave -noupdate /microprocessor_tb/pm_data_out_2
add wave -noupdate /microprocessor_tb/flush_pipeline
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {10099 ps}
