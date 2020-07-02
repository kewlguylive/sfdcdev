public without sharing class CampingListController {

    @AuraEnabled
    public static void saveItem (Camping_Item__c campingItem) {
        insert campingItem;
    }
    
    @AuraEnabled
    public static List<Camping_Item__c> getItems() {
        
        List<Camping_Item__c> campingItems = [SELECT Id,Name,Price__c,Packed__c,Quantity__c FROM Camping_Item__c];
        return campingItems;
    } 
    
    
}