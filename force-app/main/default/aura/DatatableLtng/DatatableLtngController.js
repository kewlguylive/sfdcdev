({
	doInit : function(component, event, helper) {
		var urlString = window.location.href;
         var baseURL = urlString.substring(0, urlString.indexOf("/s"));
         component.set("v.cbaseURL", baseURL);
        
        var pathArray = window.location.pathname.split('/');
        console.log("COM VAL"+pathArray);
        if(pathArray[1] === "Original"){
           component.set("v.isVertical",true); 
        }
	},
    handleClick: function(component, event, helper) {
        var urlEvent = $A.get("e.force:navigateToURL");
        var origin = component.get("v.isVertical");
        if(origin){
            urlEvent.setParams({ "url": "/Original/s/application" });   // Pass your community URL
        }else{
            urlEvent.setParams({ "url": "/CustomModel/s/orginfo" });   // Pass your community URL
        }
        
        urlEvent.fire();
    }
})