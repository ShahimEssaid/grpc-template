package template.examples;

import grpc_template.v0.Hello;
import grpc_template.v0.HelloServiceGrpc;
import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;


public class ClientExample {
    public static void main(String[] args) {
        Hello.HelloRequest hi = Hello.HelloRequest.newBuilder().setGreeting("Hi").build();
        ManagedChannel channel = ManagedChannelBuilder.forAddress("localhost", 9090).usePlaintext().build();
        HelloServiceGrpc.HelloServiceBlockingStub serviceStub = HelloServiceGrpc.newBlockingStub(channel);
        Hello.HelloResponse response = serviceStub.sayHello(hi);
        System.out.println(response.getReply());
    }
}
