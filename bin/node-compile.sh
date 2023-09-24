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

rm -rf  node/src
mkdir -p node/src

grpc_tools_node_protoc \
  -I${TMPL_PROTOS} \
  --js_out=import_style=commonjs,binary:node/src \
  --grpc_out=grpc_js:node/src \
  ${TMPL_PROTOS}/**/*.proto
