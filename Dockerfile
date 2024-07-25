FROM golang:1.22.5-alpine3.20 AS build

ENV GOPATH /usr/local

# 2da9769 is the v1.65.0 tag
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.34.2 \
  && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@2da9769

FROM alpine:3.20.1

LABEL org.opencontainers.image.authors="oa"
LABEL org.opencontainers.image.vendor="oa"
LABEL org.opencontainers.image.source="https://github.com/OA/protoc-go-action"
LABEL org.opencontainers.image.documentation="https://github.com/OA/protoc-go-action/blob/main/README.md"
LABEL org.opencontainers.image.title="protoc with go plugin"
LABEL org.opencontainers.image.description="docker image for generating go code from proto files using protoc and protoc-gen-go-grpc"
LABEL org.opencontainers.image.licenses="MIT"

RUN apk add --no-cache protobuf=24.4-r1

COPY --from=build /usr/local/bin/protoc-gen-go /usr/local/bin/protoc-gen-go
COPY --from=build /usr/local/bin/protoc-gen-go-grpc /usr/local/bin/protoc-gen-go-grpc

WORKDIR /project

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
