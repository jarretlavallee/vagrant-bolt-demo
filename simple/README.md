# Simple Bolt Usage

A vagrant file that will launch a single server and do the following actions with bolt.

1. Install the `htop` package on `server` after the `up` or `provision` commands are run
2. Output the facts for all machines after an `up` command

This simple use case shows how to use a global trigger or a machine specific trigger to perform bolt tasks. The expected output is below. 

~~~
==> server: Running action triggers after up ...
==> server: Running trigger: Bolt facts after :up...
==> server: Bolt: Running bolt command locally: bolt plan run 'facts' --boltdir '.' --run-as 'root' --inventoryfile '.vagrant/bolt_inventory.yaml' --nodes 'server'
==> server: Starting: plan facts
==> server: Starting: task facts on ssh://127.0.0.1:2222
==> server: Finished: task facts with 0 failures in 0.45 sec
==> server: Finished: plan facts in 0.46 sec
==> server: Finished on 127.0.0.1:
==> server:   {
==> server:     "os": {
==> server:       "name": "Ubuntu",
==> server:       "release": {
==> server:         "full": "14.04",
==> server:         "major": "14",
==> server:         "minor": "04"
==> server:       },
==> server:       "family": "Debian"
==> server:     }
==> server:   }
==> server: Successful on 1 node: ssh://127.0.0.1:2222
==> server: Ran on 1 node
==> server: Running trigger: Install htop after provisioning...
==> server: Bolt: Running bolt command locally: bolt task run 'package' --boltdir '.' --no-host-key-check --run-as 'root' --verbose --params '{"name":"htop","action":"install"}' --inventoryfile '.vagrant/bolt_inventory.yaml' --nodes 'server'
==> server: Started on 127.0.0.1...
==> server: Finished on 127.0.0.1:
==> server:   {
==> server:     "status": "install ok installed",
==> server:     "version": "1.0.2-3"
==> server:   }
==> server: Successful on 1 node: ssh://127.0.0.1:2222
==> server: Ran on 1 node in 1.99 seconds
~~~
