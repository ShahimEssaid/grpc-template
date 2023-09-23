# grpc-template

# Introduction
This is a setup template to compile protobuf and gRPC files into various languages.  The example files are based on the [gRPC core concepts examples](https://grpc.io/docs/what-is-grpc/core-concepts/)

# Current sestup
* Linux x86 64 based
* protobuf version b
* gRPC version 1.58
* 


# Details
The following are the relevant links, and some technical and version information for the setup at this point.

* protobuf Java
  * [protobuf Java basics](https://protobuf.dev/getting-started/javatutorial/)
  * [protobuf Java reference](https://protobuf.dev/reference/java/)
  * Setup
    * [protobuf (protoc)](https://github.com/protocolbuffers/protobuf/releases/tag/v24.3)
      * Download and unpack the [linux-x86_64](https://github.com/protocolbuffers/protobuf/releases/download/v24.3/protoc-24.3-linux-x86_64.zip) file
      * `protoc` to `repo/bin/protoc`
      * `include/google` to `repo/proto-imports/google`
  * Run `bin/java-protobuf-comile.sh` to generate the protobuf message Java source files.
    
* gRPC Java
  * [gRPC Java](https://grpc.io/docs/languages/java/)
  * [GitHub gRPC Java](https://github.com/grpc/grpc-java)
  * Setup
    * The GitHub releases do not have the needed plugin
    * However,it can be found in [the Maven repository for gRPC Java](https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/)
    * Download the [linux-x86_64](https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-java/1.58.0/protoc-gen-grpc-java-1.58.0-linux-x86_64.exe)
      * place in `repo/tools` and do not change the file name. Then `chomod 555 tools/...` it.
  