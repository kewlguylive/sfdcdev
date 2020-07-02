({
	myAction : function(component, event, helper) {
		
	},
    
    changeDivColor : function(component, event, helper) {
        console.log("clickd 22");
        
		var elem = component.find("prolink");
         //$A.util.addClass(elem, "ChangeBg");
        //$A.util.toggleClass(divCmp, 'ChangeBg');
        
       // component.set("v.IsProfile",true);
       component.set("v.disActive","spike");
        
       // $A.util.removeClass(component.find("prospan"), "slds-hide");
        
        /*
          var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
              "url": "/CustomModel/s/orginfo"
            });
            urlEvent.fire();
            */
	}
})