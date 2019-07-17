# Vagrant Bolt Demo

Vagrant-bolt is a plugin to [vagrant](https://www.vagrantup.com) that allow for using [bolt](https://puppet.com/products/bolt) in the Vagrantfile to do provisioning or triggers. More information on the plugin can be found at [the git repo](https://github.com/oscar-stack/vagrant-bolt).

This repo contains some simple use case examples that showcase some of the features of the vagrant-bolt plugin.

## How to use this repo

To use this repo, ensure that you have installed Vagrant 2.2.0+, Virtualbox, [Puppet bolt](https://puppet.com/docs/bolt/latest/bolt_installing.html), and the `vagrant-bolt` plugin. Below is how the `vagrant-bolt` plugin can be installed into vagrant.

~~~
vagrant plugin install vagrant-bolt
~~~

Once the prerequisites have been installed, you can run `vagrant up` in any of directories in this repo to spin up the demo. The `README.md` in each folder has more information on what the Vagrantfile is doing.

