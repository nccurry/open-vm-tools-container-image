# Open VM Tools Container Image

This repository hosts the Containerfile needed to build a container image that can be used to run the open source implementation of VMware Tools for Linux guest operating systems [open-vm-tools](https://docs.vmware.com/en/VMware-Tools/11.3.0/com.vmware.vsphere.vmwaretools.doc/GUID-8B6EA5B7-453B-48AA-92E5-DB7F061341D1.html). 

## Who is this image for?

The primary use-case for this image is in situations where installing the open-vm-tools RPM / DEB package is infeasible.

Fedora CoreOS virtual machines, for example, expect workloads to run containerized. A discussion around this use-case [here](https://github.com/coreos/fedora-coreos-tracker/issues/70).
 
## How to use this image?

The easiest way to use this image is as a systemd unit.

```
    [Unit]
    Description=Open VM Tools
    After=network-online.target
    Wants=network-online.target

    [Service]
    TimeoutStartSec=0
    ExecStartPre=-/bin/podman kill open-vm-tools
    ExecStartPre=-/bin/podman rm open-vm-tools
    ExecStartPre=/bin/podman pull ghcr.io/nccurry/open-vm-tools:latest
    ExecStart=/bin/podman run -v /proc/:/hostproc/ -v /sys/fs/cgroup:/sys/fs/cgroup -v /run/systemd:/run/systemd --pid=host --net=host --ipc=host --uts=host --rm  --privileged --name open-vm-tools ghcr.io/nccurry/open-vm-tools:latest

    [Install]
    WantedBy=multi-user.target
    EOT
```