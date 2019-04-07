#!/bin/bash

ipaddr=`ifconfig |grep -oP '(?:inet).*?:192.*?\s'|sed 's/inet /ip/g'`
ip1=`echo $ipaddr|grep -oP '.*?:'`
ip2=`echo $ipaddr|grep -oP '(?<=:).*'`
ip2="\\033[92m"$ip2"\\033[0m"
echo -e $ip1\\n$ip2

