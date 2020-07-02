@isTest(SeeAllData=false)
private class OrderTests {

  @testSetup
  public static void SetupTestData(){
    TestDataFactory.InsertTestData(5);
  }


  @isTest 
  private static void OrderUpdate_UnitTest(){

    Test.startTest();
    Order o = [SELECT Id, Status FROM Order LIMIT 1];
    List<OrderItem> befItems = [Select Id,quantity,Product2Id from OrderItem where OrderId =: o.Id LIMIT 1];
    
    Product2 p = [SELECT Id, Family, Name, Quantity_Ordered__c, Quantity_Remaining__c FROM Product2 WHERE Id =: befItems[0].Product2Id LIMIT 1];

    System.debug('DEEBG BFR UPDATE'+p);
   
    o.status = constants.ACTIVATED_ORDER_STATUS;
    Update o;
    
    List<OrderItem> items = [Select Id,quantity,Product2Id from OrderItem where OrderId =: o.Id LIMIT 1];
            
    Product2 updatedp = [SELECT Id, Family, Name, Quantity_Ordered__c, Quantity_Remaining__c FROM Product2 WHERE Id =: items[0].Product2Id LIMIT 1];
    System.debug('DEEBG AFTR UPDATE'+updatedp);
    
    //Product2 updatedp = [SELECT Id, Family, Name, Quantity_Ordered__c, Quantity_Remaining__c FROM Product2 WHERE Id =: p.Id LIMIT 1];
   // System.debug('DEEBG AFTR UPDATE'+updatedp);

    TestDataFactory.VerifyQuantityOrdered(p, updatedp, constants.DEFAULT_ROWS);
    Test.stopTest();

  }

  @isTest 
  private static void OrderExtension_UnitTest() {
  
    PageReference reference = Page.OrderEdit;
        Test.setCurrentPage(reference);
        Order CurOrder = [Select Id,Status from Order limit 1];
        ApexPages.StandardController controller = new Apexpages.StandardController(CurOrder);
        OrderExtension extension = new OrderExtension(controller);
        System.assertEquals(5, extension.orderItemList.size());
        extension.selectedFamily = 'Dessert';
        extension.SelectFamily();
        extension.OnFieldChange();
        extension.First();
        extension.Next();
        extension.Previous();
        extension.Last();
        extension.GetHasNext();
        extension.GetPageNumber();
        extension.GetHasPrevious();
        extension.GetTotalPages();
        extension.GetFamilyOptions();
        extension.Save();
        ChartHelper.GetInventory();
  }


  

}