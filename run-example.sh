#!/bin/bash
docker stop qBitmission
docker rm -f qBitmission
docker run --restart always --name=qBitmission \
		-v /etc/qbittorrent:/config \
		-v /mnt/download:/download \
		-e PGID=1000 -e PUID=1000 \
		-e TZ=Europe/Budapest \
		-e WEBUI_PORT=8080 \
		-e UMASK_SET=002 \
		-p 9091:9091 \
		-p 8080:8080 \
		-p 51444:51444 \ # 51444 is the torrent protocol listening port
		-p 51444:51444/udp \
		-d xmister/qbitmission
