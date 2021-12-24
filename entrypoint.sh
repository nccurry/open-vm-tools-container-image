#!/usr/bin/env bash

# Redirect logs to stdout
touch /var/log/vmware-vmsvc-root.log
tail -f /var/log/vmware-vmsvc-root.log &

# Start open-vm-tools
/usr/bin/vmtoolsd
