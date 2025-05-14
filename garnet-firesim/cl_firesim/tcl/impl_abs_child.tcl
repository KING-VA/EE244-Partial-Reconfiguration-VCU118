
# set ifrequency  [lindex $argv 0]
# set istrategy   [lindex $argv 1]
# set iboard      [lindex $argv 2]

# set desired_host_frequency $ifrequency
# # TODO: this needs to be piped through elsewhere?
# set strategy $istrategy

set project_dir ".."
set CL_DIR "$project_dir"
set garnet_dir "$project_dir/.."

set project_name "example"
set partition_module "example"

create_project -in_memory -part xcvu9p-flga2104-2L-e
set_property board_part xilinx.com:vcu118:part0:2.4 [current_project]



set_param sta.enableAutoGenClkNamePersistence 0

source "$garnet_dir/tcl/build.tcl"
# puts [get_parts *]



add_files "$CL_DIR/build/abstract_acc_post_route.dcp"
add_files "$CL_DIR/build/vector_add_partition_wrapper_ooc.dcp"
set_property SCOPED_TO_CELLS {partition_wrapper/partition/firesim_top/top/sim/target/FireSim_/chiptop0/system/tile_prci_domain/element_reset_domain_rockettile/VecAddRoCC_vectorAdd} [get_files $CL_DIR/build/vector_add_partition_wrapper_ooc.dcp]

read_xdc [ list \
 $CL_DIR/xdc/pblock_partial.xdc \
]
set_property USED_IN {implementation} [get_files $CL_DIR/xdc/pblock_partial.xdc]
set_property PROCESSING_ORDER late [get_files $CL_DIR/xdc/pblock_partial.xdc]
link_design -mode default -reconfig_partitions {partition_wrapper/partition/firesim_top/top/sim/target/FireSim_/chiptop0/system/tile_prci_domain/element_reset_domain_rockettile/VecAddRoCC_vectorAdd} -top garnet_top
# write_checkpoint -force "$CL_DIR/build/acc_post_link.dcp"

opt_design
place_design
# phys_opt_design
route_design
write_checkpoint -force "$CL_DIR/build/abstract_acc_implmeented.dcp"