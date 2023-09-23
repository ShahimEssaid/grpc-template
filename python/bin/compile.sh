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
DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"
cd "$DIR"/..

. environment

../bin/setup-environment.sh

rm -rf src/template_grpc

set +u  # needed to avoid error due to undefined variables in the .venv environment
. ../.venv/bin/activate

python3 \
      -m grpc_tools.protoc \
      -I../proto-imports \
      -I../protos \
      --python_out=src \
      --pyi_out=src \
      --grpc_python_out=src \
      ../protos/**/*.proto
