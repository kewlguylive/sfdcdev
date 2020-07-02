({
	init : function(component, event, helper) {
        
		//var navService = cmp.find("navService");
       // var anotherUrl ='/lightning/o/Account/home';
        // cmp.set("v.url", anotherUrl);
       // console.log('testing');
        // Sets the route to /lightning/o/Account/home
        /*
        var pageReference = {
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'home'
            }
        };
        
        cmp.set("v.pageReference", pageReference);
       
        var defaultUrl = "#";
        
        
        
        navService.generateUrl(pageReference)
            .then($A.getCallback(function(url) {
                cmp.set("v.url", url ? url : defaultUrl);
            }), $A.getCallback(function(error) {
                cmp.set("v.url", defaultUrl);
            })); */
       
    },
    handleClick : function(component,event, helper) {
        console.log('testing 123');
    },
    Register : function(component,event, helper) {
        console.log('testing 123t');
        ///login/SelfRegister
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
          "url": "login/SelfRegister"
        });
        urlEvent.fire();
    },
    
    doSomething : function(component,event, helper) {
       var navService = cmp.find("navService");
        // Uses the pageReference definition in the init handler
        var pageReference = cmp.get("v.pageReference");
        event.preventDefault();
        navService.navigate(pageReference);

    } ,
    
    startApplication : function(component,event, helper){
         
        console.log("start clickd");
        
        
         // gets the <lightning:navigation> tag on the component
        let navService = component.find("navService");

        // Sets the route to [Org url]/[Community uri]/[pageName]
        let pageReference = {
            type: "comm__namedPage", // community page. See https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/components_navigation_page_definitions.htm
            attributes: {
                pageName: 'applicantinformation' // pageName must be lower case
            },
            state: {
             c__firstname: 'raju'
            }
        }

        navService.navigate(pageReference);
    }
    
})