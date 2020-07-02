({
	getDataHelper : function(component, event) {
        var action = component.get("c.getObjectRecords");
        //Set the Object parameters and Field Set name
        action.setParams({
            strObjectName : 'HealthApplication__c',
            strFieldSetName : 'DataTableFieldSet'
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('res++'+response.getReturnValue().lstDataTableData);
            if(state === 'SUCCESS'){
                component.set("v.mycolumns", response.getReturnValue().lstDataTableColumns);
                component.set("v.mydata", response.getReturnValue().lstDataTableData);    
            }else if (state === 'ERROR'){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                                    errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }else{
                console.log('Something went wrong, Please check with your admin');
            }
        });
        $A.enqueueAction(action);	
    }
})