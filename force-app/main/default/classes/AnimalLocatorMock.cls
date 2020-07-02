@IsTest
global class AnimalLocatorMock implements HttpCalloutMock {
    
    global HTTPresponse respond(HTTPrequest request) {
        Httpresponse response = new Httpresponse();
        response.setStatusCode(200);
        response.setBody('{"animal":{"id":1,"name":"dinosaur","eats":"meat food","says":"mooo groo"}}');
        return response;
    }

}