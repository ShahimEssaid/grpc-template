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

cd node

if [[ ! -d .venv ]]; then
  python3 -m venv .venv
  set +u
  . .venv/bin/activate
  pip install -U pip nodeenv
  nodeenv -p
  npm install
fi










