({
	handleOnLoad : function(component, event, helper) {
          
    },
      
    handleOnSubmit : function(component, event, helper) {
         
    },
      
    handleOnSuccess : function(component, event, helper) {
         component.set("v.reloadForm", false);
        component.set("v.reloadForm", true);
    },
      
    handleOnError : function(component, event, helper) {
          
    },
    handleCreateApplication : function(component, event, helper) {
        component.find("hApp").submit();
    }
})