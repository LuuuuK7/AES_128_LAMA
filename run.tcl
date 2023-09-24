
vcom -reportprogress 300 -work work Y:/AES_128/Sources/Package_AES.vhd 

vcom -reportprogress 300 -work work Y:/AES_128/Testbench/Package_AES_tb.vhd 

vsim -gui work.package_aes_tb

add wave -divider Somme
add wave -position insertpoint \
sim:/package_aes_tb/a_add \
sim:/package_aes_tb/b_add \
sim:/package_aes_tb/sum_result

add wave -divider Multiplication_par_X
add wave -position insertpoint -radix hex\
sim:/package_aes_tb/a_mult_X \
sim:/package_aes_tb/X_mult_X \
sim:/package_aes_tb/mult_X_result

add wave -divider Multiplication
add wave -position insertpoint -radix hex \
sim:/package_aes_tb/a_mult \
sim:/package_aes_tb/b_mult \
sim:/package_aes_tb/mult_result

add wave -divider Inverse
add wave -position insertpoint \
sim:/package_aes_tb/a \
sim:/package_aes_tb/a_inv \
sim:/package_aes_tb/inv_ok


restart -f; run 400ns;
