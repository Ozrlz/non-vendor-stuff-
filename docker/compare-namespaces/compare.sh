#! /bin/bash
readarray -t PIDS <<< "$(for container in $(docker container ls | grep ${1:-nginx} | awk 'BEGIN {ORS=" "};{print $1}'); do docker inspect ${container} -f '{{.State.Pid}}'; done)"
diff -y <(ls -lisah /proc/${PIDS[0]}/ns/ | awk -F "->" '{print $2}') <(ls -lisah /proc/${PIDS[1]}/ns/ | awk -F "->" '{print $2}')