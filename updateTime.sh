#!/bin/sh 
#更新系统时间
function updateTime {
oldTime=$(date)
echo "" > /etc/chrony/chrony.conf
echo server ntp1.aliyun.com iburst >> /etc/chrony/chrony.conf
echo server cn.pool.ntp.org iburst >> /etc/chrony/chrony.conf
#启动同步服务
chronyd -f /etc/chrony/chrony.conf -d &
# 结束同步时间服务
sleep 60
echo $oldTime" -> "$(date) >> /var/log/updateTime.log
chronyc tracking >> /var/log/updateTime.log
echo  "-->" >> /var/log/updateTime.log
hwclock --systohc
pkill chronyd
}
updateTime 
echo "updateTime finish"
