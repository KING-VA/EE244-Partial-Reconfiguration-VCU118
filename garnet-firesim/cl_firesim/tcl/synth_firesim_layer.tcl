
set ifrequency  "90"
set istrategy   "TIMING"
set iboard      "xilinx_vcu118"

set desired_host_frequency $ifrequency
# TODO: this needs to be piped through elsewhere?
set strategy $istrategy

set project_dir ".."
set CL_DIR "$project_dir"
set garnet_dir "$project_dir/.."

set project_name "example"
set partition_module "example"

set_param sta.enableAutoGenClkNamePersistence 0

puts $timing_log "Running build source..."
set start [clock seconds]
source "$garnet_dir/tcl/build.tcl"
set end [clock seconds]
puts $timing_log "building source took [expr {$end - $start}] seconds"
flush $timing_log
puts [get_parts *]


time_step "garnet_create_synth_project" "garnet_create_synth_project"

# Tie-offs deliberately drive ports with constant 0
set_msg_config -id {Synth 8-3917} -suppress
# Many inputs deliberately left unused
set_msg_config -id {Synth 8-3331} -suppress


#file mkdir $CL_DIR/design/ipgen
#set ipgen_scripts [glob -nocomplain $CL_DIR/design/FireSim-generated.*.ipgen.tcl]
#foreach script $ipgen_scripts {
#    source $script
#}

# Generate targets for all IPs contained within the generated module hierarchy.
# With the exception of the PLL, these are the only IP instances that don't have
# their output artifacts checked in.
#generate_target all [get_ips]

#synth_ip [get_ips]

#source $HDK_SHELL_DIR/build/scripts/aws_gen_clk_constraints.tcl


puts $timing_log "Running setting up ips"
set start [clock seconds]


read_ip [ list \
  $CL_DIR/ip/axi_clock_converter_dramslim/axi_clock_converter_dramslim.xci \
  $CL_DIR/ip/axi_clock_converter_oclnew/axi_clock_converter_oclnew.xci \
  $CL_DIR/ip/axi_clock_converter_512_wide/axi_clock_converter_512_wide.xci \
  $CL_DIR/ip/axi_dwidth_converter_0/axi_dwidth_converter_0.xci
]

# Additional IP's that might be needed if using the DDR

read_xdc [ list \
   $CL_DIR/build/constraints/cl_synth_user.xdc \
   $CL_DIR/design/FireSim-generated.synthesis.xdc \
]

# FireSim custom clocking
source $CL_DIR/build/scripts/synth_firesim_clk_wiz.tcl

#Do not propagate local clock constraints for clocks generated in the SH
#set_property USED_IN {synthesis implementation OUT_OF_CONTEXT} [get_files cl_clocks_aws.xdc]
#set_property PROCESSING_ORDER EARLY  [get_files cl_clocks_aws.xdc]

add_files [list \
    "$CL_DIR/design/cl_firesim_defines.vh" \
    "$CL_DIR/design/FireSim-generated.defines.vh" \
    "$CL_DIR/design/cl_firesim.sv" \
    "$CL_DIR/design/FireSim-generated.sv" \
    "$CL_DIR/design/VectorAddBlackbox.v" \
]


set end [clock seconds]
puts $timing_log "setting up ips took [expr {$end - $start}] seconds"
flush $timing_log

update_compile_order -fileset sources_1

# XSDB_SLV_DIS is undocumented but used by the AWS HDK to disable the DDR XSDB
# calibration slaves, as otherwise the paths between them and the debug hub
# push the limits at 250 MHz.
time_step "garnet_synth_design" "garnet_synth_design"


# write_checkpoint -force post_synth.dcp
# get_cells -hierarchical
# puts "Checking cells:"
# puts [get_cells -hierarchical partition/firesim_top/top/sim/target/FireSim_/chiptop0/system/tile_prci_domain/element_reset_domain_rockettile/VecAddRoCC_vectorAdd]

# add_files "$garnet_dir/include/partition_wrapper_ports.vh"
# add_files ${CL_DIR}/build/vector_add_partition_wrapper_ooc.dcp
# set_property SCOPED_TO_CELLS {partition/firesim_top/top/sim/target/FireSim_/chiptop0/system/tile_prci_domain/element_reset_domain_rockettile/VecAddRoCC_vectorAdd} [get_files ${CL_DIR}/build/vector_add_partition_wrapper_ooc.dcp]
# link_design -mode out_of_context -top partition_wrapper -part xcvu9p-flga2104-2L-e
# add_files ${CL_DIR}/build/vector_add_partition_wrapper_ooc.dcp

# read_checkpoint -cell partition/firesim_top/top/sim/target/FireSim_/chiptop0/system/tile_prci_domain/element_reset_domain_rockettile/VecAddRoCC_vectorAdd ${CL_DIR}/build/vector_add_partition_wrapper_ooc.dcp
# read_edif ${CL_DIR}/build/vector_add_partition_wrapper_ooc.edf

# read_checkpoint -cell my_block_inst ./dcp/my_block_ooc.dcp


close_project