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
. ../environment

../bin/setup-environment.sh

#rm -rf src/template_grpc

set +u
. ../.venv/bin/activate

grpc_tools_node_protoc \
  -I../proto-imports \
  -I../protos \
  --js_out=import_style=commonjs,binary:src \
  --grpc_out=grpc_js:src \
   ../protos/**/*.proto


#grpc_tools_node_protoc \
#  -I../proto-imports \
#  -I../protos \
#  --js_out=import_style=commonjs,binary:src \
#  --grpc_out=generate_package_definition:src \
#   ../protos/**/*.proto

# https://www.npmjs.com/package/grpc-tools
