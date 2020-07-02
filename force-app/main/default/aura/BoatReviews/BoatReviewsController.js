({
    doInit : function (component, event, helper) {
        //Call helper
        helper.onInit(component, event, helper);
    },
    onUserInfoClick : function (component, event, helper) {
        console.log('Clieked');
        
        var userId = event.currentTarget.getAttribute('data-userid');
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            'recordId' : userId,
            'slideDevName': 'detail'
        });
        navEvt.fire();
    },
})