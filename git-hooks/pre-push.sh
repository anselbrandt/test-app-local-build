#!/bin/sh

docker build -t anselbrandt/test-app:latest .
docker push anselbrandt/test-app:latest
ssh root@anselbrandt.dev << HERE
docker pull anselbrandt/test-app:latest
docker tag anselbrandt/test-app:latest dokku/test-app
dokku tags:deploy test-app
docker system prune -a
y
HERE

exit 0