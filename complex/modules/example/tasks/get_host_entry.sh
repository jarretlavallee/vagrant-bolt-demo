#!/bin/sh
# Simple task to generate a `/etc/hosts` style entry for the node

host_entry="$(hostname -I) $(hostname -f) $(hostname -s)"

echo "{ \"host_entry\": \"${host_entry}\" }"
exit 0
