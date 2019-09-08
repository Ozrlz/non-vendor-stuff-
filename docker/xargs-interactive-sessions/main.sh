#! /bin/bash

docker container ls -q | xargs -I {} /bin/bash -c 'docker container exec -itu 0 {} sh < /dev/tty'
