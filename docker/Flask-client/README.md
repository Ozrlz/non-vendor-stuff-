# Flask client
A simple flask client that prints and returns on home ('/') the http headers that it rececives. Useful to troubleshoot LoadBalancing scenarios.

## How to use it locally (Docker)
First build the image
  > docker image build -t flask_client:1.0 .

Then, run a container:
  > docker container run --rm --name delet_this -p 5000:5000 --env-file=env_file.txt --interactive --tty flask_client:1.0

## How to use it remotely (GKE)
The client needs some env vars, which are exposed to K8s as a configMap. First you need to create it:

  > kubectl create configmap configMap-flask --from-file=./env_file.txt

After that, just create the Deployment

  > kubectl apply -f K8s-deployment.yaml
