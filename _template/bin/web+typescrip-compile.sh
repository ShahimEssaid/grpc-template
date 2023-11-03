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

set -x
${TMPL_PROTOC} \
  -I${TMPL_PROTOC_IMPORTS} \
  -Iprotos/imports \
  -Iprotos/src \
  --plugin=protoc-gen-js=${TMPL_WEB_JS_GEN} \
  --plugin=protoc-gen-grpc-web=${TMPL_WEB_GRPC_GEN} \
  --js_out=import_style=commonjs:web+typescript \
  --grpc-web_out=import_style=typescript,mode=grpcwebtext:web+typescript \
  protos/src/**/*.proto
