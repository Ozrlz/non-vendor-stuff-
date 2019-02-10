#!/bin/bash
# This will create a client-server test that can be run using kubectl directly
# It deletes everything afterwards so be careful!

set -e

if [ "$(which kubectl)" = "" ]; then
    echo "Kubectl doesn't seem to be installed or added to your path."
    exit 1
fi

kubectl run iperf-server --image=networkstatic/iperf3 --command -- iperf3 -s &&
SERVER="$(kubectl get pods -o wide|egrep -o 'iperf.*Running'|awk {'print $1'}|xargs kubectl describe pod|grep IP|awk {'print $2'})"
echo "Press ^C+ if hostname is not correct."
kubectl run -i -t iperf-client --image=networkstatic/iperf3 --command -- iperf3 -c $SERVER.default.pod.cluster.local &&
sleep 5
while true; do
    read -p "Next, it will delete all the deployments, do want to continue?" yn
    case $yn in
        [Yy]* ) kubectl delete deploy --all; break;;
        [Nn]* ) exit 0;;
        * ) echo "Please answer yes or no.";;
    esac
done
