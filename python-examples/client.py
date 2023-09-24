import grpc_template.v0.hello_pb2 as messages
import grpc_template.v0.hello_pb2_grpc as client
import grpc

request = messages.HelloRequest()
request.greeting = 'Hello'

channel = grpc.insecure_channel('localhost:9090')
stub = client.HelloServiceStub(channel)

response: messages.HelloResponse = stub.SayHello(request)

print(response.reply)
