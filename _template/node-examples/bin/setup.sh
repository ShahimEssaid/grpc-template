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
DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"

while [[ ! -r _grpcenv.sh ]]; do
  cd ..
done
#. _grpcenv.sh

cd node-examples

set -x

if [[ ! -r .venv/bin/activate ]]; then
  python3 -m venv .venv
  set +u
  . .venv/bin/activate
  pip install -U pip nodeenv
  nodeenv -p
fi

set +u
. .venv/bin/activate
rm -rf grpc-template-node-*.tgz
npm pack ../node
npm install grpc-template-node-*.tgz

# npm doesn't install transitive dependencies if we do local install or a link install
# See: https://github.com/npm/npm/issues/20835
# See: https://github.com/npm/npm/issues/21014
#









