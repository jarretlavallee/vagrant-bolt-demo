# Multi Machine Bolt Usage

A vagrant file that will launch two machines and orchestrate tasks between them. Bolt actions are listed below

1. Install the `htop` package on `server` after the `up` or `provision` commands are run
2. Output the facts for all machines after an `up` command
3. Create a file on `server` when `server2` is provisioned
4. Remove a file on `server` when `server2` is destroyed

This example multi machine use case shows how to use bolt to run commands on different machines when other machine actions are taken. This can be expanded to orchestrate actions between servers when provisioning and destroying them.


Provisioning `server2`

~~~
==> server2: Bolt: Running bolt command locally: bolt command run 'touch /tmp/server2_active' --boltdir '.' --run-as 'root' --inventoryfile '.vagrant/bolt_inventory.yaml' --nodes 'server'
==> server2: Started on 127.0.0.1...
==> server2: Finished on 127.0.0.1:
==> server2: Successful on 1 node: ssh://127.0.0.1:2222
==> server2: Ran on 1 node in 0.36 seconds
==> server2: Running action triggers after up ...
==> server2: Running trigger: Bolt facts after :up...
==> server2: Bolt: Running bolt command locally: bolt plan run 'facts' --boltdir '.' --run-as 'root' --inventoryfile '.vagrant/bolt_inventory.yaml' --nodes 'server2'
==> server2: Starting: plan facts
==> server2: Starting: task facts on ssh://127.0.0.1:2200
==> server2: Finished: task facts with 0 failures in 0.45 sec
==> server2: Finished: plan facts in 0.46 sec
==> server2: Finished on 127.0.0.1:
==> server2:   {
==> server2:     "os": {
==> server2:       "name": "Ubuntu",
==> server2:       "release": {
==> server2:         "full": "14.04",
==> server2:         "major": "14",
==> server2:         "minor": "04"
==> server2:       },
==> server2:       "family": "Debian"
==> server2:     }
==> server2:   }
==> server2: Successful on 1 node: ssh://127.0.0.1:2200
==> server2: Ran on 1 node
~~~

Manually running bolt on the machine to check the existance of the file.

~~~
➜  vagrant bolt command run 'ls -l /tmp/server2_active' -n server
Bolt: Running bolt command locally: 'bolt' 'command' 'run' 'ls -l /tmp/server2_active' '-n' 'server' --boltdir '.' --inventoryfile '.vagrant/bolt_inventory.yaml'
Started on 127.0.0.1...
Finished on 127.0.0.1:
  STDOUT:
      -rw-r--r-- 1 root root 0 Jul 17 18:23 /tmp/server2_active
      Successful on 1 node: ssh://127.0.0.1:2222
      Ran on 1 node in 0.35 seconds
~~~

Destroying `server2`

~~~
==> server2: Running action triggers before destroy ...
==> server2: Running trigger: Remove file on server before destroying...
==> server2: Bolt: Running bolt command locally: bolt command run 'rm -f /tmp/server2_active' --boltdir '.' --run-as 'root' --inventoryfile '.vagrant/bolt_inventory.yaml' --nodes 'server'
==> server2: Started on 127.0.0.1...
==> server2: Finished on 127.0.0.1:
==> server2: Successful on 1 node: ssh://127.0.0.1:2222
==> server2: Ran on 1 node in 0.34 seconds
==> server2: Ensuring requiretty is disabled...
==> server2: Running cleanup tasks for 'bolt' provisioner...
==> server2: Forcing shutdown of VM...
==> server2: Destroying VM and associated drives...
~~~

Manually running bolt on the machine to ensure the file was removed.

~~~
➜  vagrant bolt command run 'ls -l /tmp/server2_active' -n server
Bolt: Running bolt command locally: 'bolt' 'command' 'run' 'ls -l /tmp/server2_active' '-n' 'server' --boltdir '.' --inventoryfile '.vagrant/bolt_inventory.yaml'
Started on 127.0.0.1...
Failed on 127.0.0.1:
  The command failed with exit code 2
    STDERR:
        ls: cannot access /tmp/server2_active: No such file or directory
        Failed on 1 node: ssh://127.0.0.1:2222
        Ran on 1 node in 0.34 seconds
~~~
