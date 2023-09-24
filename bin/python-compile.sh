#!/usr/bin/env bash

# stack overflow #59895
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"

while [[ ! -r grpcenv.sh ]]; do
  cd ..
done
. grpcenv.sh

rm -rf  python/src
mkdir -p python/src

python \
  -m grpc_tools.protoc \
  -I${TMPL_PROTOS} \
  --python_out=python/src \
  --pyi_out=python/src \
  --grpc_python_out=python/src \
  ${TMPL_PROTOS}/**/*.proto
