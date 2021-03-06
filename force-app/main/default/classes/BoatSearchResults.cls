public with sharing class BoatSearchResults {

    
    @AuraEnabled
    public static List<Boat__c> getBoats(String boatTypeId) {

        if(String.isNotBlank(boatTypeId)) {
            List <Boat__c> boatsById = [SELECT Name, BoatType__r.Name, Contact__r.Name, Description__c, Length__c, Picture__c, Price__c, Year_Built__c, Geolocation__Latitude__s, Geolocation__Longitude__s
                                        FROM Boat__c
                                        WHERE BoatType__c =: boatTypeId];
            return boatsById;
        } else {
            List <Boat__c> allBoats = [SELECT Name, BoatType__r.Name, Contact__r.Name, Description__c, Length__c, Picture__c, Price__c, Year_Built__c, Geolocation__Latitude__s, Geolocation__Longitude__s
                                        FROM Boat__c];
            return allBoats;
        }

    }
}