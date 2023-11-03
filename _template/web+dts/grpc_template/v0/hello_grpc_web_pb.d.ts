import * as grpcWeb from 'grpc-web';

import * as grpc_template_v0_hello_pb from '../../grpc_template/v0/hello_pb';


export class HelloServiceClient {
  constructor (hostname: string,
               credentials?: null | { [index: string]: string; },
               options?: null | { [index: string]: any; });

  sayHello(
    request: grpc_template_v0_hello_pb.HelloRequest,
    metadata: grpcWeb.Metadata | undefined,
    callback: (err: grpcWeb.RpcError,
               response: grpc_template_v0_hello_pb.HelloResponse) => void
  ): grpcWeb.ClientReadableStream<grpc_template_v0_hello_pb.HelloResponse>;

}

export class HelloServicePromiseClient {
  constructor (hostname: string,
               credentials?: null | { [index: string]: string; },
               options?: null | { [index: string]: any; });

  sayHello(
    request: grpc_template_v0_hello_pb.HelloRequest,
    metadata?: grpcWeb.Metadata
  ): Promise<grpc_template_v0_hello_pb.HelloResponse>;

}

