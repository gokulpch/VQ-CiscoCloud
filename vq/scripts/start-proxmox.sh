#!/bin/bash
set -euo pipefail

docker run \
    --name vaquero \
    -d \
    -v /root/vaquero/config/dir-sot-proxmox.yaml:/vaquero/config.yaml \
    -v /root/vaquero/files:/var/vaquero/files \
    -v /root/vaquero/local:/vaquero/local \
    -v /root/vaquero/secret:/vaquero/secret \
    --net="host" \
    -e VAQUERO_SHARED_SECRET="<secret>" \
    -e VAQUERO_SERVER_SECRET="<secret>" \
    -e VAQUERO_SITE_ID="harmony-proxmox" \
    -e VAQUERO_AGENT_ID="harmony-agent" \
    shippedrepos-docker-vaquero.bintray.io/vaquero/vaquero:v0.14.3d \
        standalone --config /vaquero/config.yaml --log-level info
