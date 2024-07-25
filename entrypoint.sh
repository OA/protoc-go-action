#!/bin/sh -l

mkdir -p "$1" "$2"

protoc --go_out="$1" \
  --grpc_out="$2" \
  --plugin=protoc-gen-grpc="$(which protoc-gen-go-grpc)" \
  "$(find "$3"/ -iname "*.proto")"
