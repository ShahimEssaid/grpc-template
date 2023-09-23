if [[ ! -r grpcenv.sh  || -z ${TMPLT_ROOT:-} ]]; then
  echo "grpcenv.sh was NOT called from the root of the repository or grpcenv-project.sh was called directly. Existing 1"
  exit 1
fi

# You can create a local file to override the defaults or the project settings as needed.
# The local file is git ignored.
if [[ -r grpcenv-local.sh ]]; then
  . grpcenv-local.sh
fi

# Uncomment lines if you want to set or keep your project at one of these settings.
# See grpcenv.sh for current default values, and for how these settings affect the environment setup.

# PROTO_TOOLS=${GRPC_ROOT}/tools/${HOSTTYPE}_${OSTYPE}
# PROTO_VER=24.3
# GRPC_JAVA_VER=1.58

# # Versions for the built packages for each language.
# PACKAGE_VER=${PACKAGE_VER:-0.0.1}

# # Java version
# MVN_VER=${MVN_VER:-${PACKAGE_VER}-SNAPSHOT}
