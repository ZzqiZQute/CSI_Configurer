#!/bin/bash

PASSWD=yourpassword 

#varaibles

chn=64 # channel 13=2.472GHz,64=5.32GHz
bw=HT20 # bandwidth HT20 = 20M,HT40 = 40M iw

#Entry point

#init NIC
echo $PASSWD|sudo -S echo -n >/dev/null 2>&1
sudo modprobe -r iwlwifi mac80211
sleep 1 
sudo modprobe iwlwifi connector_log=0x1
sleep 1
sudo modprobe mac80211
sleep 1

#configure wlan
sudo service network-manager stop >/dev/null 2>&1
WLAN_INTERFACE=$(echo `iwconfig 2>/dev/null`|grep -o "wlan[0-9]")
sudo ifconfig $WLAN_INTERFACE down
sleep 0.1
sudo iwconfig $WLAN_INTERFACE mode monitor
sleep 0.1
sudo ifconfig $WLAN_INTERFACE up
sleep 0.1
sudo iw $WLAN_INTERFACE set channel $chn $bw
sudo service network-manager start >/dev/null 2>&1
echo "Change to recv complete"


