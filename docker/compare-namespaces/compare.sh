#! /bin/bash
while read PID1 PID2; do 
    diff -y <(ls -lisah /proc/$PID1/ns/ | awk -F "->" '{print $2}') <(ls -lisah /proc/$PID2/ns/ | awk -F "->" '{print $2}'); 
done <<< $(for container in $(docker container ls | grep ${1:-nginx} | awk 'BEGIN {ORS=" "};{print $1}'); do docker inspect ${container} -f '{{.State.Pid}}'; 
done)

