onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /microprocessor_tb/clk
add wave -noupdate /microprocessor_tb/reset
add wave -noupdate /microprocessor_tb/i_pins_1
add wave -noupdate /microprocessor_tb/o_reg_1
add wave -noupdate -radix hexadecimal /microprocessor_tb/pm_address_1
add wave -noupdate -radix hexadecimal /microprocessor_tb/pm_address_out_1
add wave -noupdate -radix hexadecimal /microprocessor_tb/pm_data_1
add wave -noupdate -radix hexadecimal /microprocessor_tb/pm_data_out_1
add wave -noupdate -radix hexadecimal /microprocessor_tb/ir_1
add wave -noupdate -color Orange /microprocessor_tb/i_pins_2
add wave -noupdate -color Orange /microprocessor_tb/o_reg_2
add wave -noupdate -color Orange -radix hexadecimal /microprocessor_tb/pm_address_2
add wave -noupdate -color Orange -radix hexadecimal /microprocessor_tb/pm_address_out_2
add wave -noupdate -color Orange -radix hexadecimal /microprocessor_tb/pm_data_2
add wave -noupdate -color Orange -radix hexadecimal /microprocessor_tb/data_pipe_2
add wave -noupdate -color Orange -radix hexadecimal /microprocessor_tb/pm_data_out_2
add wave -noupdate -color Orange -radix hexadecimal /microprocessor_tb/pm_data_out_2_2
add wave -noupdate -color Orange -radix hexadecimal /microprocessor_tb/ir_2
add wave -noupdate -color Orange /microprocessor_tb/flush_pipeline_2
add wave -noupdate -color Magenta /microprocessor_tb/i_pins_3
add wave -noupdate -color Magenta /microprocessor_tb/o_reg_3
add wave -noupdate -color Magenta -radix hexadecimal /microprocessor_tb/pm_address_3
add wave -noupdate -color Magenta -radix hexadecimal /microprocessor_tb/address_pipe_3
add wave -noupdate -color Magenta -radix hexadecimal /microprocessor_tb/pm_address_out_3
add wave -noupdate -color Magenta -radix hexadecimal /microprocessor_tb/pm_data_3
add wave -noupdate -color Magenta -radix hexadecimal /microprocessor_tb/data_pipe_3
add wave -noupdate -color Magenta -radix hexadecimal /microprocessor_tb/pm_data_out_3
add wave -noupdate -color Magenta -radix hexadecimal /microprocessor_tb/pm_data_out_2_3
add wave -noupdate -color Magenta -radix hexadecimal /microprocessor_tb/ir_3
add wave -noupdate -color Magenta /microprocessor_tb/flush_pipeline_3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4480685 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 257
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
WaveRestoreZoom {3331112 ps} {24889152 ps}
