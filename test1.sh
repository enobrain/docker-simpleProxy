#!/usr/bin/env bash
set -e

docker build -t ovpn-client-killswitch .
docker run --rm -it --cap-add NET_ADMIN --sysctl net.ipv6.conf.all.disable_ipv6=1 ovpn-client-killswitch bash container.sh
