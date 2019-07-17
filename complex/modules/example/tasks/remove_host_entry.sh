#!/bin/sh

declare PT__hostname

(( EUID == 0 )) || fail "This utility must be run as root"

getent hosts "$(echo ${PT__hostname})" > /dev/null || exit 0

sed -i "/^.*${PT__hostname}.*$/d" /etc/hosts
