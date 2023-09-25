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

# Versions for the built packages for each language.
TMPLT_PACKAGE_VER=${TMPLT_PACKAGE_VER:-0.0.1}

# Root for tool files
TMPLT_GRPC_TOOLS=${TMPLT_GRPC_TOOLS:-${TMPLT_ROOT}/tools/${HOSTTYPE}_${OSTYPE}}

# =============================================================================
# protoc

TMPLT_PROTOC_VER=${TMPLT_PROTOC_VER:-24.3}
TMPLT_PROTOC=${TMPLT_GRPC_TOOLS}/protoc_${TMPLT_PROTOC_VER}
TMPLT_PROTOC_IMPORTS=${TMPLT_ROOT}/proto-imports/protoc_${TMPLT_PROTOC_VER}

# =============================================================================
# project .proto files

TMPL_PROTOS=${TMPL_PROTOS:-protos}

# =============================================================================
# Java

TMPL_JAVA_GRPC_VER=${TMPL_JAVA_GRPC_VER:-1.58.0}
TMPL_JAVA_GRPC_GEN=${TMPLT_GRPC_TOOLS}/protoc-gen-grpc-java-${TMPL_JAVA_GRPC_VER}
TMPL_JAVA_OUT=${TMPL_JAVA_OUT:-java/src/main/java}


# =============================================================================
# Python

TMPL_PYTHON_TOOLS=${TMPL_PYTHON_TOOLS:-grpcio-tools}
TMPL_PYTHON_TOOLS_VER=${TMPL_PYTHON_TOOLS_VER:-1.58.0}
TMPL_PYTHON_POETRY_VER=${TMPL_PYTHON_POETRY_VER:-1.6.1}
TMPL_PYTHON_OUT=${TMPL_PYTHON_OUT:-python/src}


# =============================================================================
# Node
TMPL_NODE_TOOLS_VER=${TMPL_NODE_TOOLS_VER:-1.12.4}
TMPL_NODE_TOOLS=${TMPL_NODE_TOOLS:-grpc-tools@${TMPL_NODE_TOOLS_VER}}
TMPL_NODE_OUT=${TMPL_NODE_OUT:-node/src}


# =============================================================================

# =============================================================================
# Web
TMPL_WEB_GRPC_VER=${TMPL_WEB_GRPC_VER:-1.4.2}
TMPL_WEB_GRPC_GEN=${TMPLT_GRPC_TOOLS}/protoc-gen-grpc-web-${TMPL_WEB_GRPC_VER}

TMPL_WEB_JS_VER=${TMPL_WEB_JS_VER:-3.21.2}
TMPL_WEB_JS_GEN=${TMPLT_GRPC_TOOLS}/protoc-gen-js-${TMPL_WEB_JS_VER}

TMPL_WEB_OUT=${TMPL_WEB_OUT:-web/src}


# =============================================================================
# Setting up the virtual environment for the protos compile
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
    (pip list | grep "grpcio-tools *${TMPL_PYTHON_TOOLS_VER}") > /dev/null || { echo "Running pip install ${TMPL_PYTHON_TOOLS}==${TMPL_PYTHON_TOOLS_VER}";  pip install ${TMPL_PYTHON_TOOLS}==${TMPL_PYTHON_TOOLS_VER}; }
    (pip list | grep "poetry ") > /dev/null || { echo Running pip install poetry==${TMPL_PYTHON_POETRY_VER};  pip install poetry==${TMPL_PYTHON_POETRY_VER}; }


    ##  Node related
    (pip list | grep 'nodeenv ') > /dev/null || { echo Running pip install nodeenv;  pip install nodeenv; }
    node_path=$(which node || true)
    root_path=$(dirname "$(pwd)")
    if [[ "$node_path" == "$root_path"* ]]; then
      echo "nodejs $(node --version) already installed at $(which node)"
    else
      echo "Installing nodejs LTS"
      nodeenv -p -n lts
    fi
    (npm list -g | grep "${TMPL_NODE_TOOLS}") > /dev/null || { echo "Running npm install -g "${TMPL_NODE_TOOLS}"";  npm install -g "${TMPL_NODE_TOOLS}"; }
fi

set +u  # needed to avoid errors
. .grpcenv/bin/activate
set -u


if [[ -n ${DEBUG:-} ]]; then
  ( set -o posix ; set ) | sort | grep TMPLT_
fi

