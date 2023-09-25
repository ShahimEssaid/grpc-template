#!/usr/bin/env bash

# stack overflow #59895
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"

while [[ ! -r _grpcenv.sh ]]; do
  cd ..
done
. _grpcenv.sh

rm -rf  node/../${TMPL_NODE_OUT}
mkdir -p node/../${TMPL_NODE_OUT}

grpc_tools_node_protoc \
  -I${TMPL_PROTOC_IMPORTS} \
  -I${TMPL_PROJECT_IMPORTS} \
  -I${TMPL_PROJECT_PROTOS} \
  --js_out=import_style=commonjs,binary:${TMPL_NODE_OUT} \
  --grpc_out=grpc_js:${TMPL_NODE_OUT} \
  ${TMPL_PROJECT_PROTOS}/**/*.proto
