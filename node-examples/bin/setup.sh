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
#. grpcenv.sh

cd node-examples

if [[ ! -d .venv ]]; then
  python -m venv .venv
  set +u
  . .venv/bin/activate
  pip install -U pip nodeenv
  nodeenv -p
  rm -rf grpc-template-node-*.tgz
  npm pack ../node
  npm install grpc-template-node-*.tgz
fi

# npm doesn't install transitive dependencies if we do local install or a link install
# See: https://github.com/npm/npm/issues/20835
# See: https://github.com/npm/npm/issues/21014
#









