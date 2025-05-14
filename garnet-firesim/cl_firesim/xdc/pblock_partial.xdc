create_pblock pblock_inst_acc

add_cells_to_pblock [get_pblocks pblock_inst_acc] [get_cells -quiet [list partition_wrapper/partition/firesim_top/top/sim/target/FireSim_/chiptop0/system/tile_prci_domain/element_reset_domain_rockettile/VecAddRoCC_vectorAdd]]
resize_pblock [get_pblocks pblock_inst_acc] -add {SLICE_X85Y475:SLICE_X100Y498}
# resize_pblock [get_pblocks pblock_inst_acc] -add {DSP48E2_X9Y52:DSP48E2_X9Y67}
# resize_pblock [get_pblocks pblock_inst_acc] -add {RAMB18_X5Y52:RAMB18_X5Y67}
# resize_pblock [get_pblocks pblock_inst_acc] -add {RAMB36_X5Y26:RAMB36_X5Y33}
set_property SNAPPING_MODE ON [get_pblocks pblock_inst_acc]
set_property IS_SOFT FALSE [get_pblocks pblock_inst_acc]