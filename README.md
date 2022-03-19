# Open VM Tools Container Image

This repository hosts the Containerfile needed to build a container image that can be used to run the open source implementation of VMware Tools for Linux guest operating systems [open-vm-tools](https://docs.vmware.com/en/VMware-Tools/11.3.0/com.vmware.vsphere.vmwaretools.doc/GUID-8B6EA5B7-453B-48AA-92E5-DB7F061341D1.html). 

## Who is this image for?

The primary use-case for this image is in situations where installing the open-vm-tools RPM / DEB package is infeasible.

Fedora CoreOS virtual machines, for example, expect workloads to run containerized. A discussion around this use-case [here](https://github.com/coreos/fedora-coreos-tracker/issues/70) and an official Red Hat image can be found [here]
(https://catalog.redhat.com/software/containers/rhel7/open-vm-tools/58ee4f6e4b339a32b5fb7bae?container-tabs=dockerfile).

## How to use this image?

The easiest way to use this image is as a systemd unit.

```ini
[Unit]
Description=Open VM Tools
After=network-online.target
Wants=network-online.target

[Service]
TimeoutStartSec=0
ExecStartPre=-/bin/podman stop open-vm-tools --ignore
ExecStartPre=-/bin/podman rm open-vm-tools --ignore
ExecStartPre=/bin/podman pull ghcr.io/nccurry/open-vm-tools:latest
ExecStart=/bin/podman run \
  --privileged \
  --rm \
  -v /proc/:/hostproc/ \
  -v /sys/fs/cgroup:/sys/fs/cgroup \
  -v /var/log:/var/log \
  -v /run/systemd:/run/systemd \
  -v /sysroot:/sysroot \
  -v /etc/passwd:/etc/passwd \
  -v /etc/shadow:/etc/shadow \
  -v /etc/adjtime:/etc/adjtime \
  -v /var/lib/sss/pipes/:/var/lib/sss/pipes/:rw \
  -v /tmp:/tmp:rw \
  -v /etc/sysconfig:/etc/sysconfig:rw \
  -v /etc/resolv.conf:/etc/resolv.conf:rw \
  -v /etc/nsswitch.conf:/etc/nsswitch.conf:rw \
  -v /etc/hosts:/etc/hosts:rw \
  --net=host \
  --pid=host \
  --ipc=host \
  --uts=host \
  --name open-vm-tools \
  ghcr.io/nccurry/open-vm-tools:latest
ExecStop=-/usr/bin/podman stop open-vm-tools
ExecStopPost=-/usr/bin/podman rm open-vm-tools

[Install]
WantedBy=multi-user.target
```