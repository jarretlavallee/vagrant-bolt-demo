plan example::add_host (
  TargetSpec $nodes,
  TargetSpec $host,
){
  get_targets($host).each | $target | {
    $host_entry = run_task( 'example::get_host_entry', $target, 'Generating the host entry').find($target.name).value['host_entry']
    run_task('example::add_host_entry', $nodes, host_entry => $host_entry)
  }
}
