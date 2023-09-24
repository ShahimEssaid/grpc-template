// GENERATED CODE -- DO NOT EDIT!

'use strict';
var grpc = require('@grpc/grpc-js');
var grpc_template_v0_hello_pb = require('../../grpc_template/v0/hello_pb.js');
var google_protobuf_any_pb = require('google-protobuf/google/protobuf/any_pb.js');

function serialize_grpc_template_v0_HelloRequest(arg) {
  if (!(arg instanceof grpc_template_v0_hello_pb.HelloRequest)) {
    throw new Error('Expected argument of type grpc_template.v0.HelloRequest');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_grpc_template_v0_HelloRequest(buffer_arg) {
  return grpc_template_v0_hello_pb.HelloRequest.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_grpc_template_v0_HelloResponse(arg) {
  if (!(arg instanceof grpc_template_v0_hello_pb.HelloResponse)) {
    throw new Error('Expected argument of type grpc_template.v0.HelloResponse');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_grpc_template_v0_HelloResponse(buffer_arg) {
  return grpc_template_v0_hello_pb.HelloResponse.deserializeBinary(new Uint8Array(buffer_arg));
}


var HelloServiceService = exports.HelloServiceService = {
  sayHello: {
    path: '/grpc_template.v0.HelloService/SayHello',
    requestStream: false,
    responseStream: false,
    requestType: grpc_template_v0_hello_pb.HelloRequest,
    responseType: grpc_template_v0_hello_pb.HelloResponse,
    requestSerialize: serialize_grpc_template_v0_HelloRequest,
    requestDeserialize: deserialize_grpc_template_v0_HelloRequest,
    responseSerialize: serialize_grpc_template_v0_HelloResponse,
    responseDeserialize: deserialize_grpc_template_v0_HelloResponse,
  },
};

exports.HelloServiceClient = grpc.makeGenericClientConstructor(HelloServiceService);
