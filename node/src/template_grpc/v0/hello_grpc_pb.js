// GENERATED CODE -- DO NOT EDIT!

'use strict';
var grpc = require('@grpc/grpc-js');
var template_grpc_v0_hello_pb = require('../../template_grpc/v0/hello_pb.js');

function serialize_template_grpc_v0_HelloRequest(arg) {
  if (!(arg instanceof template_grpc_v0_hello_pb.HelloRequest)) {
    throw new Error('Expected argument of type template_grpc.v0.HelloRequest');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_template_grpc_v0_HelloRequest(buffer_arg) {
  return template_grpc_v0_hello_pb.HelloRequest.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_template_grpc_v0_HelloResponse(arg) {
  if (!(arg instanceof template_grpc_v0_hello_pb.HelloResponse)) {
    throw new Error('Expected argument of type template_grpc.v0.HelloResponse');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_template_grpc_v0_HelloResponse(buffer_arg) {
  return template_grpc_v0_hello_pb.HelloResponse.deserializeBinary(new Uint8Array(buffer_arg));
}


var HelloServiceService = exports.HelloServiceService = {
  sayHello: {
    path: '/template_grpc.v0.HelloService/SayHello',
    requestStream: false,
    responseStream: false,
    requestType: template_grpc_v0_hello_pb.HelloRequest,
    responseType: template_grpc_v0_hello_pb.HelloResponse,
    requestSerialize: serialize_template_grpc_v0_HelloRequest,
    requestDeserialize: deserialize_template_grpc_v0_HelloRequest,
    responseSerialize: serialize_template_grpc_v0_HelloResponse,
    responseDeserialize: deserialize_template_grpc_v0_HelloResponse,
  },
};

exports.HelloServiceClient = grpc.makeGenericClientConstructor(HelloServiceService);
