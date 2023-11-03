#!/usr/bin/env bash
set -x
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

# TODO
while [[ ! -r _grpcenv.sh ]]; do
  cd ..
done

. _grpcenv.sh

rm -rf  java/src/main/java/*
mkdir -p java/src/main/java

${TMPL_PROTOC} \
  -I${TMPL_PROTOC_IMPORTS} \
  -Iprotos/imports \
  -Iprotos/src \
  --plugin=protoc-gen-grpc-java=${TMPL_JAVA_GRPC_GEN} \
  --java_out=java/src/main/java \
  --grpc-java_out=java/src/main/java \
  protos/src/**/*.proto
