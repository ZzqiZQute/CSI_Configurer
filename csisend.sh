#!/bin/bash

PASSWD=yourpassword 

#varaibles

chn=64 # channel 13=2.472GHz,64=5.32GHz
bw=HT20 # bandwidth HT20 = 20M,HT40 = 40M iw
mode=0x4101 #mode

#Entry point

#init NIC
echo $PASSWD|sudo -S echo -n >/dev/null 2>&1
sudo modprobe -r iwlwifi mac80211
sudo modprobe iwlwifi debug=0x40000
sleep 0.1
sudo echo $mode | sudo tee /sys/kernel/debug/ieee80211/phy0/iwlwifi/iwldvm/debug/monitor_tx_rate >/dev/null 2>&1

#configure wlan
sudo service network-manager stop >/dev/null 2>&1
WLAN_INTERFACE=$(echo `iwconfig 2>/dev/null`|grep -o "wlan[0-9]")
sudo iw dev $WLAN_INTERFACE interface add mon0 type monitor
sudo ifconfig $WLAN_INTERFACE down
sleep 0.1
sudo ifconfig mon0 up
sleep 0.1
sudo iw mon0 set channel $chn $bw
echo "Change to send complete"
