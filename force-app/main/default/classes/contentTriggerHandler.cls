public class contentTriggerHandler {

     public void onAfterUpdate(ContentVersion[] newContentVersions,Map<Id,ContentVersion> NewMap,Map<Id,ContentVersion> OldMap){
         
     }
    
     public void onAfterInsert(ContentVersion[] newContentVersions,Map<Id,ContentVersion> NewMap,Map<Id,ContentVersion> OldMap){
         System.debug(' AFTER INSERT CVS'+newContentVersions);
         List<ContentVersion> cvList = new List<ContentVersion>();
         Set<Id> cvSet = new Set<Id>();
         
         for(Contentversion con: newContentVersions){
            // con.Status__c = 'Submitted';
             //cvList.add(con);
             cvSet.add(con.Id);
         }
         
         cvList = [select Id, Status__c from ContentVersion where Id in: cvSet and IsLatest =true];
         
         for(ContentVersion cvn: cvList){
             cvn.Status__c = 'Submitted';
         }
         
         System.debug('LAST LIST'+cvList);
         update cvList;
     }
    
     public void onBeforeUpdate(ContentVersion[] newContentVersions,Map<Id,ContentVersion> NewMap,Map<Id,ContentVersion> OldMap){
         System.debug('CVS'+newContentVersions);
         for(Contentversion con: newContentVersions){
             con.Status__c = 'Submitted';
         }
        
     }
    
    public void onBeforeInsert(ContentVersion[] newContentVersions,Map<Id,ContentVersion> NewMap,Map<Id,ContentVersion> OldMap){
         System.debug('CVS'+newContentVersions);
         for(Contentversion con: newContentVersions){
             con.Status__c = 'Submitted';
         }
         System.debug('AFTER CHNGE'+newContentVersions);
     }
}