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


source impl_abs_child.tcl