({
    onInit : function (component, event, helper) {
        
        var objectApiName = 'BoatReview__c';
        var recordTypeId = null;
        var skipCache = false;

        var service = component.find('service');
        service.getNewRecord(
            objectApiName,
            recordTypeId,
            skipCache,
            $A.getCallback(function () {
                var boatReview = component.get('v.boatReview');
                var recordError = component.get('v.recordError');
                if (recordError || boatReview === null) {
                    console.log('Error in review template: ' + recordError);
                } else {
                    boatReview.Boat__c = component.get('v.boat').Id;
                    component.set('v.boatReview', boatReview);
                }
            })
        )
    },
})