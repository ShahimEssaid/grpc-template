package template.examples;

import io.grpc.stub.StreamObserver;
import template_grpc.v0.Hello;
import template_grpc.v0.HelloServiceGrpc;

class ServiceImpl extends HelloServiceGrpc.HelloServiceImplBase {

    @Override
    public void sayHello(Hello.HelloRequest request, StreamObserver<Hello.HelloResponse> responseObserver) {
        Hello.HelloResponse response = Hello.HelloResponse.newBuilder().setReply("Reply of: " + request.getGreeting()).build();
        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }
}
