public with sharing class healthAppAuraController {

    @AuraEnabled
    public static HealthApplication__c gethealthApp(string appId) {
       HealthApplication__c hApp = new HealthApplication__c();
       if(!String.IsEmpty(appId)){
         hApp = [select Name__c, OptOut__c, Applicant__c, Account_Name__c from HealthApplication__c where Id =: appId limit 1];
       
       }
      return hApp;
    }

   @AuraEnabled
   public static List<ContentDocumentLink> getFiles(string appId){
      List<ContentDocumentLink> cdfiles= new List<ContentDocumentLink>();
      cdfiles = [SELECT ContentDocument.title, LinkedEntityId , ContentDocumentId FROM ContentDocumentLink WHERE ContentDocumentId = '069B00000073zLQIAY'];
      return cdfiles;
   
   }
    
    @AuraEnabled
   public static List<ContentVersion> getConFiles(string docId){
      List<ContentVersion> cvfiles= new List<ContentVersion>();
      cvfiles = [SELECT Id, Title, VersionNumber ,ContentDocumentId, lastmodifieddate FROM ContentVersion WHERE ContentDocumentId =: docId order by lastmodifieddate desc];
      return cvfiles;
   }
    
    @AuraEnabled
    public static List<DataTableResponse> getCDLFiles(string appId){
      List<ContentDocumentLink> cdfiles= new List<ContentDocumentLink>();
        List<DataTableResponse> responseLst = new List<DataTableResponse>();
      cdfiles = [SELECT ContentDocument.title, LinkedEntityId , ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =: appId order by ContentDocument.ContentModifiedDate desc];
       
        for(ContentDocumentLink cl: cdfiles){
            DataTableResponse dr = new DataTableResponse(cl.ContentDocument.title,cl.LinkedEntityId,cl.ContentDocumentId);
            responseLst.add(dr);
        } 
        
      return responseLst;
   }
   
   @AuraEnabled
   public static String updateFiles(string appId){
     List<ContentVersion> cv= new List<ContentVersion>();
     
     cv = [select Id, Title,Status__c, VersionNumber ,ContentDocumentId, lastmodifieddate from ContentVersion WHERE ContentDocumentId = '069B00000073zLQIAY'];
      
      if(cv.size() >0){
        for(ContentVersion c: cv){
              c.Status__c= 'Submitted';
              //c.Title = c.Title + '_02';
        }
      }
      
      update cv;
      return 'good';
   
   }
    
    public class DataTableResponse {
        @AuraEnabled
        public String Title {get;set;}
        @AuraEnabled       
        public String LinkedEntityId {get;set;}
        //@AuraEnabled
        //public String Version {get;set;}  
        @AuraEnabled
        public String ContentDocumentId {get;set;}  
        
        public DataTableResponse(String title, String linkId, String ContentDocumentId){
            //lstDataTableColumns = new List<DataTableColumns>();
            //lstDataTableData = new List<sObject>();
            this.Title = title;
            this.LinkedEntityId = linkId;
            //this.Version = ver;
            this.ContentDocumentId = ContentDocumentId; 
        }
    }
}