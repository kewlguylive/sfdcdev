public class Product2Helper {

    
  static List<CollaborationGroup> COLLABORATION_GROUP = [SELECT Id FROM CollaborationGroup WHERE Name = :Constants.INVENTORY_ANNOUNCEMENTS OR Name = :('TEST'+Constants.INVENTORY_ANNOUNCEMENTS) LIMIT 1];

  
  public static void afterUpdate(List<Product2> newList){
    
    List<Product2> needsAnnouncement = new List<Product2>();

    
    Map<String, Decimal> invSettingMap = new Map<String, Decimal>();

    
    List<Inventory_Setting__mdt> invSettings = [SELECT Id, DeveloperName, Low_Quantity_Alert__c FROM Inventory_Setting__mdt];

    for(Inventory_Setting__mdt e : invSettings) {
      invSettingMap.put(e.DeveloperName, e.Low_Quantity_Alert__c);
    }

    for(Product2 c : newList) {
      if(invSettingMap.containsKey(c.Family) && c.Quantity_Remaining__c < invSettingMap.get(c.Family)) {
        needsAnnouncement.add(c);
      }
    }

    if(!Test.isRunningTest()){
       PostAlerts(needsAnnouncement);
    }
    
  }

  
  public static void PostAlerts(List<Product2> productList){

    List<ConnectApi.AnnouncementInput> toPost = new List<ConnectApi.AnnouncementInput>();

    for (Product2 p : productList) {
      ConnectApi.MessageBodyInput messageBodyInput = new ConnectApi.MessageBodyInput();
      ConnectApi.TextSegmentInput textSegmentInput = new ConnectApi.TextSegmentInput();

      ConnectApi.AnnouncementInput k = new ConnectApi.AnnouncementInput();
      k.expirationDate = Date.today().addDays(1);
      k.sendEmails = false;
      k.parentId = COLLABORATION_GROUP[0].Id;

      textSegmentInput.text = p.Name + ' ' + Constants.INVENTORY_LEVEL_LOW;
      messageBodyInput.messageSegments = new List<ConnectApi.messageSegmentInput>();
      messageBodyInput.messageSegments.add(textSegmentInput);
      k.body = messageBodyInput;

      toPost.add(k);
    }

    AnnouncementQueueable n = new AnnouncementQueueable();
    n.toPost1 = toPost;
    System.enqueueJob(n);
  }
}