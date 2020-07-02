({
	myAction : function(component, event, helper) {
		
	},
    handleFilesChange : function(component, event, helper) {
		var fList = component.get("v.FileList");
        console.log('FILES++'+fList);
	}
})