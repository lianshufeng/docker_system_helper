#!/bin/sh 

fileName="/tmp/"$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 8)".sh"
echo fileName :  $fileName

#生成更新脚本
curl --unix-socket /var/run/docker.sock http:/v1.40/images/json | jq '.[].RepoTags' | jq 'select(. != null )[]' | jq 'select(. != "<none>:<none>" )' >  $fileName

echo "docker pull image -> "

#打印所有镜像列表
cat $fileName

sed -i 's/^/curl -XPOST --unix-socket \/var\/run\/docker.sock http:\/localhost\/images\/create?fromImage=/' $fileName

#执行脚本
sh $fileName

#删除临时文件
rm -rf $fileName


echo "finish."