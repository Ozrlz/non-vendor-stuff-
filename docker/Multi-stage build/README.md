# Multi-stage builds with docker

A simple way to create tiny images, building first using a temporal container and copying the binary into a different base image.

## Usage
A simple build command is enough (Needs docker 17.05 or higher on both, server and client)

```bash
docker image build . -t gotest:1.0
```

https://docs.docker.com/develop/develop-images/multistage-build/