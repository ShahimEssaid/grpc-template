#!/usr/bin/env bash

# A simple check if we're in the repository root.
if [[ ! -r grpcenv.sh  ]]; then
  echo "grpcenv.sh was NOT called from the root of the repository. Existing 1"
  exit 1
fi

TMPLT_ROOT=$(pwd)

#set -x
set -e
set -u
set -o pipefail
set -o noclobber
shopt -s nullglob
shopt -s globstar

. grpcenv-project.sh

TMPLT_GRPC_TOOLS=${TMPLT_GRPC_TOOLS:-${TMPLT_ROOT}/tools/${HOSTTYPE}_${OSTYPE}}

# =============================================================================
# protoc

TMPLT_PROTOC_VER=${TMPLT_PROTOC_VER:-24.3}
TMPLT_PROTOC=${TMPLT_GRPC_TOOLS}/protoc_${TMPLT_PROTOC_VER}
TMPLT_PROTOC_IMPORTS=${TMPLT_ROOT}/proto-imports/protoc_${TMPLT_PROTOC_VER}

# =============================================================================
# project protoc

TMPL_PROTOS=${TMPL_PROTOS:-protos}

# =============================================================================
# Java example

TMPL_JAVA_GRPC_VER=${TMPL_JAVA_GRPC_VER:-1.58.0}
TMPL_JAVA_GRPC_GEN=${TMPLT_GRPC_TOOLS}/protoc-gen-grpc-java-${TMPL_JAVA_GRPC_VER}
TMPL_JAVA_OUT=${TMPL_JAVA_OUT:-java/src/main/java}






# protoc_gen_grpc-java
TMPLT_GRPC_JAVA_VER=${TMPLT_GRPC_JAVA_VER:-1.58}

# Versions for the built packages for each language.
TMPLT_PACKAGE_VER=${TMPLT_PACKAGE_VER:-0.0.1}

# Java version
TMPLT_MVN_VER=${TMPLT_MVN_VER:-${TMPLT_PACKAGE_VER}-SNAPSHOT}

# Python version
#PY_VER=${PY_VER:-${PACKAGE_VER}}


if [[ ${TMPLT_GRPCENV:-setup} == setup || ! -d .grpcenv ]]; then
    if [[ ! -d .grpcenv ]]; then
      python3 -m venv .grpcenv
      . .grpcenv/bin/activate
      pip install -U pip
    fi

    set +u
    . .grpcenv/bin/activate
    set -u

    ##  Python related
    #(pip list | grep -F 'grpcio ') > /dev/null ||  { echo Running pip install grpcio; pip install grpcio==1.58.0; }
    (pip list | grep -F 'grpcio-tools ') > /dev/null || { echo Running pip install grpcio-tools;  pip install grpcio-tools==1.58.0; }
    (pip list | grep -F 'poetry ') > /dev/null || { echo Running pip install grpcio-tools;  pip install poetry; }


    ##  Node related
    (pip list | grep -F 'nodeenv ') > /dev/null || { echo Running pip install nodeenv;  pip install nodeenv; }
    node_path=$(which node || true)
    root_path=$(dirname "$(pwd)")
    if [[ "$node_path" == "$root_path"* ]]; then
      echo "nodejs $(node --version) already installed at $(which node)"
    else
      echo "Installing nodejs"
      nodeenv -p -n lts
    fi
    (npm list | grep -F 'grpc-tools@1.12.4') > /dev/null || { echo "Running npm install -g grpc-tools@1.12.4";  npm install -g grpc-tools@1.12.4; }

fi

set +u  # needed to avoid errors
. .grpcenv/bin/activate
set -u


if [[ ! -z ${DEBUG:-} ]]; then
  ( set -o posix ; set ) | sort | grep TMPLT_
fi

