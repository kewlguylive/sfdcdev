({
	handleClick: function(component, event, helper) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({ "url": "/CustomModel/s/orginfo" });   // Pass your community URL
        urlEvent.fire();
    }
})