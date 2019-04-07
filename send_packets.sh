#!/bin/bash

PASSWD=yourpassword
PKGSIZE=100
WAITTIME=3
COUNTDOWN=5
print_middle(){
    LINES=`tput lines`
    str=$1
    typ=$2
    echo $str
    len=${#str}
    echo $len
    height=10
    t=`expr $LINES - $height`
    y=`expr $t / 2`
    echo -ne "\\033[2J\\033[${y};1H"
    if [ $typ = 0 ];then
        echo $str|toilet -f mono12 
    else
        echo $str|toilet -f mono12  --gay
    fi
}
if [ $# = 1 ];then
    if [ $1 = "-h" ];then
        echo "Usage :./send_packets <number> <delay(s)> <waittime> <countdown>"
        exit 0
    else
        pkgnum=$1
    fi
fi
if [ $# = 2 ];then
    pkgnum=$1
    delay=$2
fi
if [ $# = 3 ];then
    pkgnum=$1
    delay=$2
    WAITTIME=$3
fi
if [ $# = 4 ];then
    pkgnum=$1
    delay=$2
    WAITTIME=$3
    COUNTDOWN=$4
fi
if [ ! -e "./random_packets" ];then
    echo -e "\\033[91mSend package program not found!\\033[0m"
    exit -1
fi
echo $PASSWD|sudo -S echo -e "\\033[2J\\033[1;1H"
echo verify ok!
if [ -z $pkgnum ];then
    echo -n Input package num:
    read pkgnum
fi
if [ -z $delay ];then
    echo -n Input delay\(s\):
    read delay
fi
echo "Total time:`echo "scale=2;$pkgnum * $delay"|bc`s" 
sleep 0.5
print_middle Ready? 1
while [ $WAITTIME != 0 ];do
    print_middle $WAITTIME 0
    echo -e "\\033[1;1HTotal time:`echo "scale=2;$pkgnum * $delay"|bc`s"
    WAITTIME=`echo "$WAITTIME - 1"|bc`
    #mpv bibi.wav >/dev/null 2&>1 &
    sleep 1
done
#mpv beep.wav >/dev/null 2&>1 &
sudo ./random_packets $pkgnum 100 1 `echo "$delay * 1000000"|bc`&
trap "clear;echo -e \"\\\\033[92mrandom_packets killed!\\\\033[0m\";echo sys522|sudo -S pkill -9 random_packets;exit" INT
print_middle GO 1
echo -e "\\033[1;1HTotal time:`echo "scale=2;$pkgnum * $delay"|bc`s"
if [ `echo "$delay * $pkgnum - $COUNTDOWN <= 0"|bc` = 1 ];then
    sleep  `echo "$delay * $pkgnum"|bc`
    print_middle FINISH 1
    #mpv beep.wav >/dev/null 2&>1 &
else 
    sleep `echo "$delay * $pkgnum - $COUNTDOWN"|bc`
    #while [ $COUNTDOWN != 0 ];do
        #print_middle $COUNTDOWN 0
        #echo -e "\\033[1;1HTotal time:`echo "scale=2;$pkgnum * $delay"|bc`s"
        #COUNTDOWN=`echo "$COUNTDOWN - 1"|bc`
        #mpv bibi.wav >/dev/null 2&>1 &
        #sleep 1
    #done
    print_middle FINISH 1
    mpv beep.wav >/dev/null 2&>1 &
fi

