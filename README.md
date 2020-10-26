# docker_system_helper
auto freemem and update system time


- env
````shell
ENV ntpd_host cn.pool.ntp.org
ENV uptetime_timer 1800
ENV freemem_timer 1800
````



- docker-compose.yml
````shell
version: "3"

services:

  systemhelper:
    image: lianshufeng/systemhelper
    privileged: true
    environment:
      - ntpd_host=cn.pool.ntp.org
      - uptetime_timer=15
      - freemem_timer=10
    volumes:
      # docker api
      - "/var/run/docker.sock:/var/run/docker.sock"
      # free mem
      - "/proc/sys/vm/drop_caches:/drop_caches"
      # log
      - "/var/log/systemhelper/:/var/log/"
    container_name: docker_systemhelper
    # update time auth
    cap_add:
      - SYS_TIME
    restart: always
````


- docker-compose-arm.yml
````shell
version: "3"

services:

  systemhelper:
    image: lianshufeng/systemhelper
    privileged: true
    environment:
      - ntpd_host=cn.pool.ntp.org
      - uptetime_timer=15
      - freemem_timer=10
    volumes:
      # docker api
      - "/var/run/docker.sock:/var/run/docker.sock"
      # free mem
      - "/proc/sys/vm/drop_caches:/drop_caches"
      # log
      - "/var/log/systemhelper/:/var/log/"
    container_name: docker_systemhelper
    # update time auth
    cap_add:
      - SYS_TIME
    restart: always
````