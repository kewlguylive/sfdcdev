({
    doInit: function(component) {
        // Set the attribute value. 
        // You could also fire an event here instead.
       // component.set("v.setMeOnInit", "controller init magic!");
    },
	handleClick : function(component, event, helper) {
		var navg = component.find('nav2');
        $A.util.removeClass(navg, 'slds-is-active');
        
        var curNav = component.find('nav3');
        $A.util.addClass(curNav, 'slds-is-active');
        
        component.set("v.displayNav", true);
        
	}
})