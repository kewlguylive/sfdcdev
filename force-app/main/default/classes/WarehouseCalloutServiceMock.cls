@isTest
global class WarehouseCalloutServiceMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest request){
        
        System.assertEquals('https://th-superbadge-apex.herokuapp.com/equipment', request.getEndpoint());
        System.assertEquals('GET', request.getMethod());
        
    	// Create a fake response
		HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
		response.setBody('[{"_id":"55d66278726g611900yyf741","replacement":false,"quantity":18,"name":"Generator 5000 kW","maintenanceperiod":366,"lifespan":150,"cost":9100,"sku":"100003"}]');
        response.setStatusCode(200);
        return response;
    }
}