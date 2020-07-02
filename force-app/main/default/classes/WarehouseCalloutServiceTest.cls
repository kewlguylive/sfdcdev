@isTest
private class WarehouseCalloutServiceTest {
 
	@isTest
    static void WarehouseEquipmentSync(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock()); 
         WarehouseCalloutService.runWarehouseEquipmentSync();
        Test.stopTest();        
        System.assertEquals(1, [SELECT count() FROM Product2]);        
    }   
}