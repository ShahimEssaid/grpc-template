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

rm -rf  java/src/main/java/*
mkdir -p java/src/main/java

${TMPLT_PROTOC} \
  -I${TMPLT_PROTOC_IMPORTS} \
  -I${TMPL_PROTOS} \
  --plugin=protoc-gen-grpc-java=${TMPL_JAVA_GRPC_GEN} \
  --java_out=${TMPL_JAVA_OUT} \
  --grpc-java_out=${TMPL_JAVA_OUT} \
  ${TMPL_PROTOS}/**/*.proto
