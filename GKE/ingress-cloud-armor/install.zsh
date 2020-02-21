#! /bin/zsh
POLICY_NAME="policy-1"

set -e
case "$1" in
  apply)
    # First, create the backendConfig CRD
    kubectl apply -f BackendConfig.yaml

    # Create the certs and secret
    cd certs
    source generate.sh
    kubectl create secret tls cert1 \
      --cert flask.ozrlz.com.crt --key flask.ozrlz.com.key
    cd ..

    # Create cloud armor policy and rules
    gcloud compute security-policies create ${POLICY_NAME} \
        --description "policy 1 for test purposes"
    # Update default rule and set to deny
    gcloud compute security-policies rules update 2147483647 \
        --security-policy ${POLICY_NAME} \
        --action "deny-404"

    # Add a new rule to only allow your requests
    gcloud compute security-policies rules create 100000 \
        --security-policy ${POLICY_NAME} \
        --description "allow traffic from my pc only" \
        --src-ip-ranges $(curl -s ifconfig.io) \
        --action "allow"

    # Create a static ip
    gcloud compute addresses create cloud-armor-static --global

    # Create app and ingress
    ls *.yaml | xargs -L 1 kubectl apply -f 
    ;;
  delete)
    # Delete k8s resources
    ls *.yaml | xargs -L 1 kubectl delete -f
    echo "Waiting for ingress to delete GCLB ..."
    sleep 100
    # Delete cloud armor policy and rules
    gcloud compute security-policies delete ${POLICY_NAME} 

    # Delete a static ip
    gcloud compute addresses delete cloud-armor-static --global

    # Delete certs
    cd certs
    rm *.(crt|key|csr)

    # Create the secret
    kubectl delete secret cert1 
    ;;
  *)
    echo "Usage: $0 apply|delete"
    exit 1
esac