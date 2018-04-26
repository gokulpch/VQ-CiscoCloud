#!/bin/bash
set -euo pipefail

VROOT=/root/vaquero
FILES=${VROOT}/files

# copy the vaquero SoT and our atomic ISO we'll need in the
# kickstart
mount /dev/cdrom /mnt
mkdir -p ${FILES}
cp /mnt/rhel-atomic.iso ${FILES}
umount /mnt

# mount the ISO and get the bits we need out of it
mount ${FILES}/rhel-atomic.iso /mnt

# pxe boot images
mkdir -p ${FILES}/images
cp /mnt/images/pxeboot/* ${FILES}/images

# the entire ISO
mkdir -p ${FILES}/atomic-install-repo
cp -pr /mnt/* ${FILES}/atomic-install-repo

# and the atomic ostree from inside the rootfs image stored inside
# the squasfs image
mkdir /tmp/squashfs
mkdir /tmp/rootfs
mount -o loop ${FILES}/atomic-install-repo/LiveOS/squashfs.img /tmp/squashfs
mount -o loop /tmp/squashfs/LiveOS/rootfs.img /tmp/rootfs

mkdir -p ${FILES}/rhel-atomic-install
cp -pr /tmp/rootfs/install/* ${FILES}/rhel-atomic-install

# tar up all the things we need for netbooting so we can easily
# mirror them to other nodes
tar vcf ${FILES}/netboot.tar -C ${FILES} atomic-install-repo images rhel-atomic-install

chcon -Rt svirt_sandbox_file_t ${VROOT}

umount /tmp/rootfs /tmp/squashfs /mnt
rm -rf /tmp/rootfs /tmp/squashfs

# make sure vaquero container can read the files while
# selinux is enforcing
chcon -Rt svirt_sandbox_file_t ${VROOT}

rm -rf ${VROOT}/local/sites/harmony-g1a