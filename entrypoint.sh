#!/bin/sh




#启动调度器服务
#crond


nohup watch -n $uptetime_timer  /opt/updateTime.sh &

nohup watch -n $freemem_timer  /opt/freemem.sh &


watch -n 60 "echo keep live :  $(date)"