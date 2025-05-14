
# set ifrequency  "90"
# set istrategy   "TIMING"
# set iboard      "xilinx_vcu118"

# set desired_host_frequency $ifrequency
# # TODO: this needs to be piped through elsewhere?
# set strategy $istrategy

# set project_dir ".."
# set CL_DIR "$project_dir"
# set garnet_dir "$project_dir/.."

set project_name "example"
set partition_module "example"

set_param sta.enableAutoGenClkNamePersistence 0

source "$garnet_dir/tcl/build.tcl"
puts [get_parts *]



set_param sta.enableAutoGenClkNamePersistence 1

time_step "garnet_create_impl_project" "parent garnet_create_impl_project" 

read_xdc [ list \
 $CL_DIR/build/constraints/cl_pnr_user.xdc \
 $CL_DIR/design/FireSim-generated.implementation.xdc
]

set_property PROCESSING_ORDER late [get_files cl_pnr_user.xdc]
set_property PROCESSING_ORDER late [get_files FireSim-generated.implementation.xdc]

time_step "garnet_link_design" "parent garnet_link_design"

time_step "garnet_opt_design" "parent garnet_opt_design"
time_step "garnet_place_design" "parent garnet_place_design"
time_step "garnet_route_design" "parent garnet_route_design + write"


time_step "garnet_report_timing" "parent garnet_report_timing"
# garnet_write_artifacts

close_project
