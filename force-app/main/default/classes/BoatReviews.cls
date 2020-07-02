public with sharing class BoatReviews{
  
    @AuraEnabled
    public static List<BoatReview__c> getAll(Id boatId) {
        //Commit to July2020 Branch
        List<BoatReview__c> boatReviews = new List<BoatReview__c>();
        return [SELECT Id,Name,Comment__c,Rating__c,LastModifiedDate,CreatedDate,CreatedBy.Name, CreatedBy.CompanyName, CreatedBy.SmallPhotoUrl
                       FROM BoatReview__c WHERE Boat__c =: boatId];
         
    }
}