package template.examples;

import io.grpc.*;
import io.grpc.stub.StreamObserver;
import template_grpc.v0.Hello;
import template_grpc.v0.HelloServiceGrpc;

import java.io.IOException;

public class ServerExample {
    private Server server;

    public static void main(String[] args) throws IOException, InterruptedException {
        ServerExample serverExample = new ServerExample();
        serverExample.start();

        Runtime.getRuntime().addShutdownHook(new Thread() {
            @Override
            public void run() {
                // Use stderr here since the logger may have been reset by its JVM shutdown hook.
                System.err.println("*** shutting down gRPC server since JVM is shutting down");
                try {
                    serverExample.stop();
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
                System.err.println("*** server shut down");
            }
        });
        System.out.println("Started server, waiting on termination.");
        serverExample.server.awaitTermination();
    }

    private void start() throws IOException {
        ServerCredentials credentials = InsecureServerCredentials.create();
        ServerBuilder<?> serverBuilder = Grpc.newServerBuilderForPort(9090, credentials);
        serverBuilder.addService(new ServiceImpl());
        server = serverBuilder.build();
        server.start();
    }

    private void stop() throws InterruptedException {
        server.shutdown().awaitTermination();
    }


}

