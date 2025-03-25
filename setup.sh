#!/bin/bash
echo "ADJUST YOUR CADDYFILE!"
sleep 2
echo "backing up your /etc/docker/daemon.json"

# if you have a daemon.json, we make a backup
if [ -f /etc/docker/daemon.json ]; then
    echo "Ensuring that your docker installation supports ipv6"
    cp -i /etc/docker/daemon.json /etc/docker/daemon.json.backup # interactive in case you run this script twice and do not want to overwrite your old bakup
    rm /etc/docker/daemon.json
fi

printf "{\n  \"ipv6\": true,\n  \"fixed-cidr-v6\": \"fd00::/80\"\n}\n" >/etc/docker/daemon.json
systemctl restart docker

docker build -t debug:latest .
docker compose up -d
echo "--------------"
echo "check if the docker subnet is correctly set in the Caddyfile"
echo "docker network: "
docker inspect caddy | grep Gateway
echo "Caddy trusted proxies: "
cat Caddyfile | grep trusted_proxies

# after you are done testing.
# rm /etc/docker/daemon.json
# cp /etc/docker/daemon.json.backup /etc/docker/daemon.json
