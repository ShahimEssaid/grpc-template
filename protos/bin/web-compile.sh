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

rm -rf  web/../${TMPL_WEB_OUT}
mkdir -p web/../${TMPL_WEB_OUT}

set -x
${TMPLT_PROTOC} \
  -I${TMPLT_PROTOC_IMPORTS} \
  -I${TMPL_PROTOS} \
  --plugin=protoc-gen-js=${TMPL_WEB_JS_GEN} \
  --plugin=protoc-gen-grpc-web=${TMPL_WEB_GRPC_GEN} \
  --js_out=import_style=commonjs:${TMPL_WEB_OUT} \
  --grpc-web_out=import_style=commonjs,mode=grpcwebtext:${TMPL_WEB_OUT} \
  ${TMPL_PROTOS}/**/*.proto