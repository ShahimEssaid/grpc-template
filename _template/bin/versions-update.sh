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
TMPL_DIR="$(cd -P "$(dirname "$SOURCE")" && pwd)"

while [[ ! -r _grpcenv.sh ]]; do
  cd ..
done

. _grpcenv.sh

cd "${TMPL_DIR}/.."

sed -i "0,/<\/version>/{s/<version>.*<\/version>/<version>${TMPL_PROJECT_VER_MVN}<\/version>/}" java/pom.xml
sed -i "0,/description/{s/version = \".*\"/version = \"${TMPL_PROJECT_VER_PYTHON}\"/}" python/pyproject.toml
sed -i "0,/description/{s/version\": \".*\"/version\": \"${TMPL_PROJECT_VER_NODE}\"/}" node/package.json
sed -i "0,/description/{s/version\": \".*\"/version\": \"${TMPL_PROJECT_VER_WEB}\"/}" web/package.json
