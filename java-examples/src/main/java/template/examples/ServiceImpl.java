package template.examples;

import grpc_template.v0.Hello;
import grpc_template.v0.HelloServiceGrpc;
import io.grpc.stub.StreamObserver;


class ServiceImpl extends HelloServiceGrpc.HelloServiceImplBase {

    @Override
    public void sayHello(Hello.HelloRequest request, StreamObserver<Hello.HelloResponse> responseObserver) {
        Hello.HelloResponse response = Hello.HelloResponse.newBuilder().setReply("Reply of: " + request.getGreeting()).build();
        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }
}
