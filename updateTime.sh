#!/bin/sh 
#释放缓存
function updateTime {
oldTime=$(date)
echo servers ${ntpd_host} > /opt/ntpd.conf
ntpd -f /opt/ntpd.conf -s
hwclock --systohc
echo $oldTime" -> "$(date) >> /var/log/updateTime.log
}
updateTime 
echo "updateTime finish"
