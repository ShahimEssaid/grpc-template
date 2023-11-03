# A Git ignored local file can be used to set values
[[ -r "etc/env-local.sh" ]] && . "etc/env-local.sh"

# A flag variable to indicate if the setup code should run with each script.
# Running the setup code slows down scripts, so it can be turned off with this variable.
#
TMPL_SETUP=${TMPL_SETUP:-setup}

TMPL_PROJECT_VER=0.0.55
TMPL_PROJECT_VER_MVN=${TMPL_PROJECT_VER}-SNAPSHOT
TMPL_PROJECT_VER_PYTHON=${TMPL_PROJECT_VER}
TMPL_PROJECT_VER_NODE=${TMPL_PROJECT_VER}
TMPL_PROJECT_VER_WEB=${TMPL_PROJECT_VER}

TMPL_PROTOC_VER=24.3
TMPL_JAVA_GRPC_VER=1.58.0
TMPL_PYTHON_TOOLS_VER=1.58.0
TMPL_PYTHON_POETRY_VER=1.6.1
TMPL_NODE_TOOLS_VER=1.12.4
TMPL_WEB_JS_VER=3.21.2
TMPL_WEB_GRPC_VER=1.4.2
