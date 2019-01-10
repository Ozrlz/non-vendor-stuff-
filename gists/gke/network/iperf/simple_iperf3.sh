#!/bin/bash
# This will create a client-server test that can be run using kubectl directly
# It deletes everything afterwards so be careful!

set -ex


kubectl run iperf-server --image=networkstatic/iperf3 --command -- iperf3 -s &&
SERVER="$(kubectl get pods -o wide|egrep -o 'iperf.*Running'|awk {'print $1'}|xargs kubectl describe pod|grep IP|awk {'print $2'})"
echo "Press ^C+ if hostname is not correct."
kubectl run -i -t iperf-client --image=networkstatic/iperf3 --command -- iperf3 -c $SERVER.default.pod.cluster.local &&
sleep 5
kubectl delete deploy --all
