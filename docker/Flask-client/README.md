#Flask client
A simple flask client that prints and returns on home ('/') the http headers that it rececives. Useful to troubleshoot LoadBalancing scenarios.

##How to use it
First build the image
  > docker image build -t flask_client:1.0 .

Then, run a container:
  > docker container run --rm --name delet_this -p 5000:5000 --env-file=env_file.txt --interactive --tty flask_client:1.0
