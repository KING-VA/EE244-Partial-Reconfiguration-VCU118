set ifrequency  [lindex $argv 0]
set istrategy   [lindex $argv 1]
set iboard      [lindex $argv 2]

set desired_host_frequency $ifrequency
# TODO: this needs to be piped through elsewhere?
set strategy $istrategy

set project_dir ".."
set CL_DIR "$project_dir"
set CL_BUILD_DIR "$project_dir/build"
set garnet_dir "$project_dir/.."

set project_name "acc_pm"

source synth_firesim_layer.tcl

source synth_acc.tcl

source impl_parent.tcl

source subdivide_acc.tcl

source impl_child.tcl