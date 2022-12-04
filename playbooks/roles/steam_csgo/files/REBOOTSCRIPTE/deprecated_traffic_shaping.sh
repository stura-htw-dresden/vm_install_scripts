#!/bin/bash  
# Full path to tc binary 

TC=$(which tc)

#
# NETWORK CONFIGURATION
# interface - name of your interface device
# interface_speed - speed in mbit of your $interface
# ip - IP address of your server, change this if you don't want to use
#      the default catch all filters.
#
interface=ppp0
interface_speed=500mbit

# control bandwidth per IP
declare -A ipctrl
# define list of IP and bandwidth (in kilo bits per seconds) below
for hostpart in `seq 10  200`
do
    ipctrl[10.57.82.$hostpart]="$((500 * 1024 / 200))"
done


# Define the upload and download speed limit, follow units can be 
# passed as a parameter:
# kbps: Kilobytes per second
# mbps: Megabytes per second
# kbit: kilobits per second
# mbit: megabits per second
# bps: Bytes per second
download_limit="$((500 / 200))mbit"
upload_limit="$((500 / 200))mbit"


# Filter options for limiting the intended interface.
FILTER="$TC filter add dev $interface protocol ip parent 1: prio 1 u32"

#
# This function starts the TC rules and limits the upload and download speed
# per already configured earlier.
# 

function start_tc { 
    tc qdisc show dev $interface | grep -q "qdisc pfifo_fast 0"  
    [ "$?" -gt "0" ] && tc qdisc del dev $interface root; sleep 1  

    # start the tc configuration
    $TC qdisc add dev $interface root handle 1: htb default 30
    $TC class add dev $interface parent 1: classid 1:1 htb rate $interface_speed burst 15k

    $TC class add dev $interface parent 1:1 classid 1:10 htb rate $download_limit burst 15k
    $TC class add dev $interface parent 1:1 classid 1:20 htb rate $upload_limit burst 15k

    $TC qdisc add dev $interface parent 1:10 handle 10: sfq perturb 10
    $TC qdisc add dev $interface parent 1:20 handle 20: sfq perturb 10

    # Apply the filter rules
    
    # Catch-all IP rules, which will set global limit on the server
    # for all IP addresses on the server. 
    #$FILTER match ip dst 0.0.0.0/0 flowid 1:10
    #$FILTER match ip src 0.0.0.0/0 flowid 1:20

    # If you want to limit the upload/download limit based on specific IP address
    # you can comment the above catch-all filter and uncomment these:
    #
    # $FILTER match ip dst $ip/32 flowid 1:10
    # $FILTER match ip src $ip/32 flowid 1:20
    for ip in "${!ipctrl[@]}"
    do
     $FILTER match ip dst $ip/32 flowid 1:10
     $FILTER match ip src $ip/32 flowid 1:20
    done
}

#
# Removes the network speed limiting and restores the default TC configuration
#
function stop_tc {
    tc qdisc show dev $interface | grep -q "qdisc pfifo_fast 0"
    [ "$?" -gt "0" ] && tc qdisc del dev $interface root
}

function show_status {
        $TC -s qdisc ls dev $interface
}
#
# Display help 
#
function display_help {
        echo "Usage: tc [OPTION]"
        echo -e "\tstart - Apply the tc limit"
        echo -e "\tstop - Remove the tc limit"
        echo -e "\tstatus - Show status"
}

# Start
if [ -z "$1" ]; then
        display_help
elif [ "$1" == "start" ]; then
        start_tc
elif [ "$1" == "stop" ]; then
        stop_tc
elif [ "$1" == "status" ]; then
        show_status
fi
