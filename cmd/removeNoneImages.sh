#!/bin/sh 

fileName="/tmp/"$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 8)".sh"
echo fileName :  $fileName

#生成更新脚本
curl --unix-socket /var/run/docker.sock http:/localhost/images/json  | jq .[] | jq 'select( .RepoTags == null )' | jq -r '.Id' >  $fileName

echo "docker remove image -> "
#打印所有镜像列表
cat $fileName

sed -i 's/^/curl -XDELETE --unix-socket \/var\/run\/docker.sock http:\/localhost\/images\//' $fileName
sed -i 's/$/?force\=true/' $fileName

#执行脚本
sh $fileName

#删除临时文件
rm -rf $fileName


echo "finish."