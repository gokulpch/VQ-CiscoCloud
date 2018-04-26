#!/bin/bash
set -euo pipefail

DISKS=$(find /dev -regex '^/dev/[sv]d[a-z]+$' -printf '%P\n')
for DISK in ${DISKS}; do
    echo "Wiping ${DISK}"
    END=$(cat /sys/block/${DISK}/size | awk '{ print $1 - 64 }')
    dd if=/dev/zero "of=/dev/$DISK" bs=512 count=64 oflag=direct
    dd if=/dev/zero "of=/dev/$DISK" bs=512 count=64 "seek=$END" oflag=direct
done
echo "MBR wiped."
