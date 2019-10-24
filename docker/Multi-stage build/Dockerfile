FROM golang:latest AS builder
WORKDIR /go/src/github.com/ozrlz/return-headers
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM scratch
workdir /home/gouser/
copy --from=builder /go/src/github.com/ozrlz/return-headers/app .
ENTRYPOINT ["./app"]
