
# set ifrequency  [lindex $argv 0]
# set istrategy   [lindex $argv 1]
# set iboard      [lindex $argv 2]

set desired_host_frequency $ifrequency
# TODO: this needs to be piped through elsewhere?
set strategy $istrategy

set project_dir ".."
set CL_DIR "$project_dir"
set garnet_dir "$project_dir/.."

set project_name "example"

open_checkpoint "$CL_DIR/build/acc_post_route.dcp"
write_abstract_shell -force -cell partition_wrapper/partition/firesim_top/top/sim/target/FireSim_/chiptop0/system/tile_prci_domain/element_reset_domain_rockettile/VecAddRoCC_vectorAdd "$CL_DIR/build/abstract_acc_post_route.dcp"