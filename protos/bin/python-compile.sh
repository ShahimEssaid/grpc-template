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

rm -rf  python/../${TMPL_PYTHON_OUT}
mkdir -p python/../${TMPL_PYTHON_OUT}

python \
  -m grpc_tools.protoc \
  -I${TMPL_PROTOS} \
  --python_out=${TMPL_PYTHON_OUT} \
  --pyi_out=${TMPL_PYTHON_OUT} \
  --grpc_python_out=${TMPL_PYTHON_OUT} \
  ${TMPL_PROTOS}/**/*.proto
