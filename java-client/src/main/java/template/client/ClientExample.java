package template.client;

import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;
import template_grpc.v0.Hello;
import template_grpc.v0.HelloServiceGrpc;

public class ClientExample {
    public static void main(String[] args) {
        Hello.HelloRequest hi = Hello.HelloRequest.newBuilder().setGreeting("Hi").build();
        ManagedChannel channel = ManagedChannelBuilder.forAddress("localhost", 9090).usePlaintext().build();
        HelloServiceGrpc.HelloServiceBlockingStub serviceStub = HelloServiceGrpc.newBlockingStub(channel);
        Hello.HelloResponse response = serviceStub.sayHello(hi);
        System.out.println(response.getReply());
    }
}
