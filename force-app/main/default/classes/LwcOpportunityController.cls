public with sharing class LwcOpportunityController {
   
 @AuraEnabled(cacheable=true)
        public static list<Opportunity> getOpportunities(String recordId){
          return [SELECT Id,Name, AccountId, Amount, StageName FROM Opportunity WHERE Id =:recordId];
        }
}
