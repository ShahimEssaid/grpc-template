var template = require('grpc-template-node');
var grpc = require('@grpc/grpc-js')

var helloRequest = new template.v0.HelloRequest();
helloRequest.setGreeting("Hello");

var credentials = grpc.credentials.createInsecure();
clinet = new template.v0.HelloServiceClient('localhost:9090', grpc.credentials.createInsecure());
clinet.sayHello(helloRequest, function (err, response){
    console.log(response.getReply())
})