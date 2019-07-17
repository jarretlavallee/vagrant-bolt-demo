#!/bin/sh

declare PT_host_entry

(( EUID == 0 )) || fail "This utility must be run as root"

getent hosts "$(echo ${PT_host_entry} | awk '{print $2}')" > /dev/null && exit 0

echo "${PT_host_entry}" >> /etc/hosts
