#!/bin/bash
set -euo pipefail

docker run \
    --name agent0 \
    -d \
    -v /root/vq/config/dir-sot-g1a.yaml:/vaquero/config.yaml \
    -v /root/vq/files:/var/vaquero/files \
    -v /root/vq/local:/vaquero/local \
    -v /root/vq/secret:/vaquero/secret \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --net="host" \
    --privileged \
    -e VAQUERO_SHARED_SECRET="<secret>" \
    -e VAQUERO_SERVER_SECRET="<secret>" \
    -e VAQUERO_SITE_ID="site1" \
    -e VAQUERO_AGENT_ID="agent0" \
    filez.lab.dfj.io:5000/vaquero:yakbulut \
        agent --config /vaquero/config.yaml --log-level debug
