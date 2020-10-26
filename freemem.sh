#!/bin/sh 
#释放缓存
function freemem {
used=`free -m | awk 'NR==2' | awk '{print $3}'`
free=`free -m | awk 'NR==2' | awk '{print $4}'`
echo "===========================" >> /var/log/mem.log
date >> /var/log/mem.log
echo "Memory usage | [Use：${used}MB][Free：${free}MB]" >> /var/log/mem.log
sync && echo 1 > /drop_caches
sync && echo 2 > /drop_caches
sync && echo 3 > /drop_caches
echo "OK" >> /var/log/mem.log

}
freemem 
echo "freemem finish"
