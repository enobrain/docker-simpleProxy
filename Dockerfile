FROM ubuntu:18.04

RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt install -y openvpn iptables

COPY container.sh container.sh
COPY hma.ovpn hma.ovpn
COPY login.conf login.conf
