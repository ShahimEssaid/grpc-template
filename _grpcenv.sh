#!/usr/bin/env bash

# A simple check if we're in the repository root.
if [[ ! -r _grpcenv.sh  ]]; then
  echo "_grpcenv.sh was NOT called from the root of the repository. Existing 1"
  exit 1
fi

TMPL_ROOT=$(pwd)

. _grpcenv-project.sh

TMPL_TEMPLATE=${TMPL_ROOT}/${TMPL_TEMPLATE}
TMPL_PROJECT=${TMPL_ROOT}/${TMPL_PROJECT}

if [[ ! -d ${TMPL_PROJECT} ]]; then
  cp -a  "${TMPL_TEMPLATE}" "${TMPL_PROJECT}"
fi

. "${TMPL_PROJECT}/etc/env.sh"

# =====================
# Tooling
TMPL_TOOLS=${TMPL_ROOT}/_tools/${HOSTTYPE}_${OSTYPE}
TMPL_PROTOC=${TMPL_TOOLS}/protoc_${TMPL_PROTOC_VER}
TMPL_PROTOC_IMPORTS=${TMPL_ROOT}/_tools/imports/protoc_${TMPL_PROTOC_VER}

# =============================================================================
# Java
TMPL_JAVA_GRPC_GEN=${TMPL_TOOLS}/protoc-gen-grpc-java-${TMPL_JAVA_GRPC_VER}

# =============================================================================
# Python
TMPL_PYTHON_TOOLS=grpcio-tools

# =============================================================================
# Node
TMPL_NODE_TOOLS=grpc-tools@${TMPL_NODE_TOOLS_VER}

# =============================================================================
# Web

TMPL_WEB_GRPC_GEN=${TMPL_TOOLS}/protoc-gen-grpc-web-${TMPL_WEB_GRPC_VER}
TMPL_WEB_JS_GEN=${TMPL_TOOLS}/protoc-gen-js-${TMPL_WEB_JS_VER}
TMPL_WEB_OUT=${TMPL_PROJECT}/web


# =============================================================================
# Setting up the virtual environment for the protos compile
if [[ ${TMPL_SETUP} == setup || ! -d _grpcenv ]]; then
    if [[ ! -d _grpcenv ]]; then
      python3 -m venv _grpcenv
      . _grpcenv/bin/activate
      pip install -U pip
    fi

    set +u
    . _grpcenv/bin/activate
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
. _grpcenv/bin/activate
set -u

if [[ -n ${DEBUG:-} ]]; then
  ( set -o posix ; set ) | sort | grep TMPL_
fi

