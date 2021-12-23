FROM registry.fedoraproject.org/fedora-minimal:latest

LABEL summary="Open Virtual Machine Tools container for virtual machines hosted on VMware." \
      name="ghcr.io/nccurry/open-vm-tools" \
      version="latest" \
      com.redhat.component="open-vm-tools" \
      description="The open-vm-tools project is an open source implementation of VMware Tools. It is a suite of open source virtualization utilities and drivers to improve the functionality, user experience and administration of VMware virtual machines. This package contains only the core user-space programs and libraries of open-vm-tools." \
      io.k8s.description="The open-vm-tools project is an open source implementation of VMware Tools. It is a suite of open source virtualization utilities and drivers to improve the functionality, user experience and administration of VMware virtual machines. This package contains only the core user-space programs and libraries of open-vm-tools." \
      io.k8s.display-name="open-vm-tools" \
      io.openshift.tags="open-vm-tools,vmware" \
      maintainer="Nick Curry <code@nickcurry.com>"

ENV SYSTEMD_IGNORE_CHROOT=1

RUN microdnf install -y --nodocs open-vm-tools

CMD ["/usr/bin/vmtoolsd"]
