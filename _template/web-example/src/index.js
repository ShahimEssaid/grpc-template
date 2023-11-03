const web_example = require('grpc-template-web');
// const s = require('grpc-template-web/v0/hello_grpc_web_pb');


var request = new web_example.v0.HelloRequest();
request.setGreeting('Hello')

var client = new web_example.v0.HelloServiceClient('http://localhost:8888', null, null);

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

