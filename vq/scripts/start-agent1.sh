#!/bin/bash
set -euo pipefail

docker run \
    --name agent1 \
    -d \
    -v /root/vaquero/config/dir-sot-g1a.yaml:/vaquero/config.yaml \
    -v /root/vaquero/files:/var/vaquero/files \
    -v /root/vaquero/local:/vaquero/local \
    -v /root/vaquero/secret:/vaquero/secret \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --net="host" \
    --privileged \
    -e VAQUERO_SHARED_SECRET="<secret>" \
    -e VAQUERO_SERVER_SECRET="<secret>" \
    -e VAQUERO_SITE_ID="g1-node1" \
    -e VAQUERO_AGENT_ID="agent1" \
    filez.lab.dfj.io:5000/vaquero:abetest68 \
        agent --config /vaquero/config.yaml --log-level debug
