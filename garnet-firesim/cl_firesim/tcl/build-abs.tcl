set ifrequency  [lindex $argv 0]
set istrategy   [lindex $argv 1]
set iboard      [lindex $argv 2]

set desired_host_frequency $ifrequency
# TODO: this needs to be piped through elsewhere?
set strategy $istrategy

set start_total [clock seconds]

set project_dir ".."
set CL_DIR "$project_dir"
set CL_BUILD_DIR "$project_dir/build"
set CL_TCL_DIR "$project_dir/tcl"
set garnet_dir "$project_dir/.."
set log_file_path "$CL_DIR/timing.log"
set timing_log [open "$log_file_path" "a"]


proc time_step {step_cmd step_name} {
    global timing_log
    puts $timing_log "Running $step_name..."
    set start [clock seconds]
    eval $step_cmd
    set end [clock seconds]
    puts $timing_log "$step_name took [expr {$end - $start}] seconds"
    flush $timing_log
}



# source "$CL_TCL_DIR/synth_firesim_layer.tcl"

# source "$CL_TCL_DIR/synth_acc.tcl"

# source "$CL_TCL_DIR/impl_parent.tcl"

# time_step "source $CL_TCL_DIR/subdivide_acc.tcl" "subdivide step"

# source "$CL_TCL_DIR/impl_child.tcl"

# time_step "source $CL_TCL_DIR/create_abstract_shell_acc.tcl" "create abstract shell"

time_step "source $CL_TCL_DIR/impl_abs_child.tcl" "implement abs child"



set end_total [clock seconds]
puts $timing_log "total time took [expr {$end_total - $start_total}] seconds"
flush $timing_log

close $timing_log