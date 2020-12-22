#!/bin/sh

nohup watch -n $uptetime_timer  /opt/updateTime.sh &

nohup watch -n $freemem_timer  /opt/freemem.sh &


watch -n 60 "echo keep live :  $(date)"

