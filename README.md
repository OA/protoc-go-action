# protoc go action

this action runs the protoc compiler with the go plugin.

## example usage

### github action

```yaml
name: build

on:
  release:
    types: [ published ]

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - name: checkout repository
        uses: actions/checkout@v4

      - name: compile proto files
        uses: oa/protoc-go-action@0.1.1
        with:
          go-out: service/pb
          grpc-out: service/pb
          proto-file-directory: proto
```

### docker run

```shell
docker run --rm -v $(pwd):/project ghcr.io/oa/protoc-go-action:0.1.1 service/pb service/pb proto
```
