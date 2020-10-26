FROM alpine:3
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

#同步时间主机的域名
ENV ntpd_host cn.pool.ntp.org
#同步系统时间
ENV uptetime_timer 1800
#释放系统内存
ENV freemem_timer 1800


RUN apk update \
	&& apk add --no-cache --update curl  openntpd


#自动释放内存
COPY freemem.sh /opt/freemem.sh
RUN chmod -R 777 /opt/freemem.sh




#自动同步系统时间
COPY updateTime.sh /opt/updateTime.sh
RUN chmod -R 777 /opt/updateTime.sh


#拷贝初始化文件
COPY entrypoint.sh /entrypoint.sh
RUN chmod -R 777 /entrypoint.sh
ENTRYPOINT sh /entrypoint.sh