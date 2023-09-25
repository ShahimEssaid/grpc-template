const m = require('grpc-template-web/src/grpc_template/v0/hello_pb');
const s = require('grpc-template-web/src/grpc_template/v0/hello_grpc_web_pb');

var request = new m.HelloRequest();
request.setGreeting('Hello')

var client = new s.HelloServiceClient('http://localhost:8888', null, null);

var call = client.sayHello(request, null, function (err, response){
    console.log(response.getReply());
});

// var call = client.sayHello(request);


// call.on('data', function (data){
//     console.log("DATA")
//    console.log(data.getGreeting())
// });

call.on('end', function (){
    console.log('call ended')
})

// call.on('error', function (e){
//     console.log('Error')
//     console.log(e)
// })

call.on('status', function (status){
    console.log('Status:')
    console.log(JSON.stringify(status, null, 2))
})

