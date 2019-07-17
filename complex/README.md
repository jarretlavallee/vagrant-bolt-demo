# Bolti Plan Usage

A vagrant file that will launch two machines and orchestrate tasks between them. Bolt actions are listed below

1. For any new machine provisioned, it will add an entry to the `/etc/hosts` to all running machines
2. For any machine destroyed, it will remove the host entry for the node from the `/etc/hosts` on all running machines.

This example multi machine use case shows how to use bolt to run bolt plans and tasks on multiple machines when they are provisioned. This simple example allows for managing the `/etc/hosts` entries across multiple machines without the use of a vagrant plugin.

When provisioning a server, the bolt plan from the `modules` directory is called to manage the hosts on all of the nodes. It generates the host entry from the `ip` address hostname inside the virtual machine. More information on how to write tasks and plans can be found in the [bolt documentation](https://puppet.com/docs/bolt/latest/writing_tasks_and_plans.html).

~~~
Bringing machine 'server' up with 'virtualbox' provider...
Bringing machine 'server2' up with 'virtualbox' provider...
==> server: Checking if box 'ubuntu/trusty64' version '20190429.0.1' is up to date...
==> server: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> server: flag to force provisioning. Provisioners marked to run always will still run.
==> server: Running action triggers after up ...
==> server: Running trigger: Bolt managing hosts...
==> server: Bolt: Running bolt command locally: bolt plan run 'example::add_host' --boltdir '.' --run-as 'root' --params '{"host":"server"}' --inventoryfile '.vagrant/bolt_inventory.yaml' --nodes 'server2,server'
==> server: Starting: plan example::add_host
==> server: Starting: Generating the host entry on ssh://127.0.0.1:2222
==> server: Finished: Generating the host entry with 0 failures in 0.39 sec
==> server: Starting: task example::add_host_entry on ssh://127.0.0.1:2200, ssh://127.0.0.1:2222
==> server: Finished: task example::add_host_entry with 0 failures in 0.4 sec
==> server: Finished: plan example::add_host in 0.81 sec
==> server: Plan completed successfully with no result
==> server2: Checking if box 'ubuntu/trusty64' version '20190429.0.1' is up to date...
==> server2: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> server2: flag to force provisioning. Provisioners marked to run always will still run.
==> server2: Running action triggers after up ...
==> server2: Running trigger: Bolt managing hosts...
==> server2: Bolt: Running bolt command locally: bolt plan run 'example::add_host' --boltdir '.' --run-as 'root' --params '{"host":"server2"}' --inventoryfile '.vagrant/bolt_inventory.yaml' --nodes 'server2,server'
==> server2: Starting: plan example::add_host
==> server2: Starting: Generating the host entry on ssh://127.0.0.1:2200
==> server2: Finished: Generating the host entry with 0 failures in 0.39 sec
==> server2: Starting: task example::add_host_entry on ssh://127.0.0.1:2200, ssh://127.0.0.1:2222
==> server2: Finished: task example::add_host_entry with 0 failures in 0.38 sec
==> server2: Finished: plan example::add_host in 0.79 sec
==> server2: Plan completed successfully with no result

~~~

Confirming the `/etc/hosts` have been updated:

~~~
➜  vagrant bolt command run 'grep server /etc/hosts' -n all
Bolt: Running bolt command locally: 'bolt' 'command' 'run' 'grep server /etc/hosts' '-n' 'all' --boltdir '.' --inventoryfile '.vagrant/bolt_inventory.yaml'
Started on 127.0.0.1...
Started on 127.0.0.1...
Finished on 127.0.0.1:
  STDOUT:
    127.0.1.1   server.demo     server
    10.0.2.15  server2.demo server2
Finished on 127.0.0.1:
  STDOUT:
    127.0.1.1   server2.demo    server2
    10.0.2.15  server.demo server
Successful on 2 nodes: ssh://127.0.0.1:2200,ssh://127.0.0.1:2222
Ran on 2 nodes in 0.40 seconds

~~~
