import * as jspb from 'google-protobuf'

import * as google_protobuf_any_pb from 'google-protobuf/google/protobuf/any_pb';


export class HelloRequest extends jspb.Message {
  getGreeting(): string;
  setGreeting(value: string): HelloRequest;

  getAny(): google_protobuf_any_pb.Any | undefined;
  setAny(value?: google_protobuf_any_pb.Any): HelloRequest;
  hasAny(): boolean;
  clearAny(): HelloRequest;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): HelloRequest.AsObject;
  static toObject(includeInstance: boolean, msg: HelloRequest): HelloRequest.AsObject;
  static serializeBinaryToWriter(message: HelloRequest, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): HelloRequest;
  static deserializeBinaryFromReader(message: HelloRequest, reader: jspb.BinaryReader): HelloRequest;
}

export namespace HelloRequest {
  export type AsObject = {
    greeting: string,
    any?: google_protobuf_any_pb.Any.AsObject,
  }
}

export class HelloResponse extends jspb.Message {
  getReply(): string;
  setReply(value: string): HelloResponse;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): HelloResponse.AsObject;
  static toObject(includeInstance: boolean, msg: HelloResponse): HelloResponse.AsObject;
  static serializeBinaryToWriter(message: HelloResponse, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): HelloResponse;
  static deserializeBinaryFromReader(message: HelloResponse, reader: jspb.BinaryReader): HelloResponse;
}

export namespace HelloResponse {
  export type AsObject = {
    reply: string,
  }
}

