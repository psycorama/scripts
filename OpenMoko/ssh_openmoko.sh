#!/bin/bash

#use local user
LUSER=andy

if [ $UID -ne 0 ]; then
    echo "this better be ran as root..."
fi

DEV=usb0
R_IP=192.168.7.2
L_IP=192.168.7.1
NET=192.168.7
TARGET=debian

while [ $# -gt 0 ]; do 
    case $1 in
	"-i")
	    shift 1
	    DEV=$1
	    shift 1
	    ;;
	"-d")
	    shift 1
	    R_IP=$1
	    NET=`echo $1|cut -d '.' -f 1-3`
	    IP=$(($((`echo $1|cut -d '.' -f 4`))-1))
	    if [ $IP -lt 1 ]; then
		echo "remote IP should noti be less than .2"
		exit -1;
	    fi
	    L_IP=$NET.$IP
	    echo "using $R_IP as remote IP and $L_IP as local"
	    shift 1
	    ;;
	"-t")
	    shift 1
	    TARGET=$1
	    shift 1
	    ;;
	*)
	    echo "usage: $0 -t TARGET [-d Interface] [-i IP]"
	    echo "   -t TARGET should debian[default] or SHR"
	    echo "   -i IP defaults to 192.168.7.2(remote) and 192.168.7.1(lokal)"
	    echo "   -d Interface is usb0 [default], tends to change..."
	    exit -1;
	    ;;
	esac
done

#setting up network
ip address add $L_IP/24 dev $DEV
ip link set dev $DEV up

/sbin/route add -host $R_IP/32 dev $DEV

if [ `iptables -t nat -L POSTROUTING -n|grep -c $NET` -lt 1 ]; then
    iptables -A POSTROUTING -t nat -j MASQUERADE -s $R_IP/24
    iptables -P FORWARD ACCEPT
else
    echo "masquerading already present"
fi
if [ `sysctl net.ipv4.ip_forward|cut -c 23` -ne 1 ]; then
    sysctl -w net.ipv4.ip_forward=1
else
    echo "forwarding already active"
fi

#copying /etc/resolv.conf, just to be sure...
su $LUSER -c "scp -o UserKnownHostsFile=/home/$LUSER/.ssh/knownOM_$TARGET /etc/resolv.conf root@$R_IP:/etc/resolv.conf"
#connecting
su $LUSER -c "ssh -o UserKnownHostsFile=/home/$LUSER/.ssh/knownOM_$TARGET -X root@$R_IP"
