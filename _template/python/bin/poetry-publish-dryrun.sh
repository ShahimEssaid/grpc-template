#!/usr/bin/env bash

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
. _grpcenv.sh

cd python
rm -rf dist
poetry -vvv publish --build --dry-run -u __token__
