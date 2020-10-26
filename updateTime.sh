#!/bin/sh 
#更新系统时间
function updateTime {
oldTime=$(date)
echo servers ${ntpd_host} > /opt/ntpd.conf
ntpd -f /opt/ntpd.conf -s 
hwclock --systohc
echo $oldTime" -> "$(date) >> /var/log/updateTime.log
# 结束同步时间服务
sleep 5
pkill ntpd
}
updateTime 
echo "updateTime finish"
