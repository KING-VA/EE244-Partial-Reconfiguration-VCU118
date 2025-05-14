
set ifrequency  [lindex $argv 0]
set istrategy   [lindex $argv 1]
set iboard      [lindex $argv 2]

set desired_host_frequency $ifrequency
# TODO: this needs to be piped through elsewhere?
set strategy $istrategy

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



add_files "$CL_DIR/build/subdivide_acc.dcp"
add_files "$CL_DIR/build/vector_add_partition_wrapper_ooc.dcp"
set_property SCOPED_TO_CELLS {partition_wrapper/partition/firesim_top/top/sim/target/FireSim_/chiptop0/system/tile_prci_domain/element_reset_domain_rockettile/VecAddRoCC_vectorAdd} [get_files $CL_DIR/build/vector_add_partition_wrapper_ooc.dcp]

read_xdc [ list \
 $CL_DIR/xdc/pblock_partial.xdc \
]
set_property USED_IN {implementation} [get_files $CL_DIR/xdc/pblock_partial.xdc]
set_property PROCESSING_ORDER late [get_files $CL_DIR/xdc/pblock_partial.xdc]

puts $timing_log "Running acc link_design..."
set start [clock seconds]
link_design -mode default -reconfig_partitions {partition_wrapper/partition/firesim_top/top/sim/target/FireSim_/chiptop0/system/tile_prci_domain/element_reset_domain_rockettile/VecAddRoCC_vectorAdd} -top garnet_top
set end [clock seconds]
puts $timing_log "acc link_design took [expr {$end - $start}] seconds"
flush $timing_log


# write_checkpoint -force "$CL_DIR/build/acc_post_link.dcp"

time_step "opt_design" "acc opt_design"
time_step "place_design" "acc place_design"
# phys_opt_design
time_step "route_design" "acc route_design"

puts $timing_log "Running acc write_checkpoint..."
set start [clock seconds]
write_checkpoint -force "$CL_DIR/build/acc_post_route.dcp"
set end [clock seconds]
puts $timing_log "acc write_checkpoint source took [expr {$end - $start}] seconds"
flush $timing_log

