#!/usr/bin/env bash
#set -x
set -e
set -u
set -o pipefail
set -o noclobber
shopt -s nullglob
shopt -s globstar
# stack overflow #59895
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
TMPL_BIN="$(cd -P "$(dirname "$SOURCE")" && pwd)"

while [[ ! -r _grpcenv.sh ]]; do
  cd ..
done

. _grpcenv.sh

cd "${TMPL_BIN}/.."

# this command is from the _grpcenv virtual environment
# https://github.com/grpc/grpc-node/tree/master/examples/helloworld/static_codegen
grpc_tools_node_protoc \
  -I${TMPL_PROTOC_IMPORTS} \
  -Iprotos/imports \
  -Iprotos/src \
  --js_out=import_style=commonjs,binary:node \
  --grpc_out=grpc_js:node \
  protos/src/**/*.proto
