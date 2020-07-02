public without sharing class OrderHelper {

    public static void AfterUpdate(List<Order> newList, List<Order> oldList){
    Set<Id> activatedOrderIds = new Set<Id>();

    //Create list of OrderIds
    for (Integer i = 0; i < newList.size(); i++) {
      if(newList[i].Status == Constants.ACTIVATED_ORDER_STATUS && oldList[i].Status == Constants.DRAFT_ORDER_STATUS) {
        activatedOrderIds.add(newList[i].Id);
      }
    }
   System.debug('IDS NEW'+activatedOrderIds);
    RollUpOrderItems(activatedOrderIds);
  }

  
  public static void RollUpOrderItems(Set<Id> activatedOrderIds){

     //ToDo: Declare a Map named "productMap" of Ids to Product2 records
        Map<Id,Product2> productMap = new Map<Id,Product2>();
        List<Id> productIds = new List<Id>();
        
        for(OrderItem item : [Select id,quantity,Product2Id from OrderItem where orderId in :activatedOrderIds]) {
            productIds.add(item.Product2Id);
        }
        
        //ToDo: Populate the map with the Id of the related Product2 as the key and Product2 record as the value
        productMap = new Map<Id,Product2>([Select id,Quantity_Ordered__c from product2 where id in :productIds]);
        //ToDo: Loop through a query that aggregates the OrderItems related to the Products in the ProductMap keyset
        AggregateResult[] groupedResult = [Select Product2Id,sum(Quantity) totalQuantity from OrderItem where product2Id in :productMap.keySet() group by product2Id];
        
        //ToDo: Perform an update on the records in the productMap
        for(AggregateResult result : groupedResult) {
            productMap.get((String)result.get('Product2Id')).Quantity_Ordered__c = Integer.valueOf(result.get('totalQuantity'));
        }
        
        System.debug('PM MAP NEW'+productMap);
        if(productMap!=null && productMap.size() > 0) {
            update productMap.values();
        }
   
  }

}