#!/bin/sh
set -ue

# Setup iptables: Allow openvpn to connet eth0 and everythin else only
# throug tun0
groupadd --system killswitch
iptables -A OUTPUT -m owner --gid-owner killswitch -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 10000 -j ACCEPT
iptables -A OUTPUT -o tun0 -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -j REJECT --reject-with icmp-admin-prohibited

# Create a tun0 device for openvpn
mkdir -p /dev/net
mknod /dev/net/tun c 10 200

# Owervrite whatever in resolv.conf
echo nameserver 8.8.8.8 > /etc/resolv.conf

# Run ovpn
sg killswitch 'openvpn --config hma.ovpn' &

bash
