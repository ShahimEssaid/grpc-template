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

rm -rf  python/src
mkdir -p python/src

python \
  -m grpc_tools.protoc \
  -Iprotos/imports \
  -Iprotos/src \
  --python_out=python/src \
  --pyi_out=python/src \
  --grpc_python_out=python/src \
  protos/src/**/*.proto
