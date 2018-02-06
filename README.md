# bind-docker
Bind DNS server with Webmin UI on Docker

This image provides a BIND DNS server with Webmin UI.

## How to start the BIND server
```bash
docker run -d --name bind \
	-v /data/bind/:/data \
	-p 10000:10000 \
    -p 53:53/udp \
	--restart always \
	amritanshu16/bind-docker:0.1.0

## Replace '/data/bind/' by the directory of your choice.
```

## How to access the BIND server and Webmin UI
- Inside the container Webmin UI runs on `port 10000`
- BIND DNS server listens on `port 53`

