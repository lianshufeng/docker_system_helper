#!/bin/sh 

fileName="/tmp/"$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 8)".sh"
echo fileName :  $fileName


#生成更新脚本 docker ps -a 过滤失效的进程
curl --unix-socket /var/run/docker.sock http:/localhost/containers/json?filters=%7b%22status%22%3a+%5b%22exited%22%5d%7d | jq -r '.[].Id'  >  $fileName

echo "docker rm ->"
cat $fileName

sed -i 's/^/curl -XDELETE --unix-socket \/var\/run\/docker.sock http:\/localhost\/containers\//' $fileName


#执行脚本
sh $fileName

#删除临时文件
rm -rf $fileName


echo "finish."