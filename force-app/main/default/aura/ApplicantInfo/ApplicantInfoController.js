({
	myAction : function(component, event, helper) {
		
	},
    onPageReferenceChange: function(cmp, event, helper) {
       console.log("page2 response");
        var urlString = window.location.href;
        var baseURL = urlString.substring(0, urlString.indexOf("/s"));
        baseURL = baseURL+'/sfc/servlet.shepherd/version/download/resource/1579782645000/IP_Agreement';
        
        cmp.set("v.templink",baseURL);
        
        var myPageRef = cmp.get("v.pageReference");
        cmp.set("v.myRecordId", "a0FB0000003TSV5");
        cmp.set("v.recordId", "a0FB0000003TSV5");
          //cmp.set("v.firstname", "Hello");
        
           var hId = "069B00000074HCiIAM";
           cmp.set("v.healthId", hId);
           cmp.set('v.myCVcolumns', [
            {label: 'Title', fieldName: 'Title', type: 'text'},
                {label: 'VersionNumber', fieldName: 'VersionNumber', type: 'text'},
                {label: 'ContentDocumentId', fieldName: 'ContentDocumentId', type: 'reference'}
             ]);
            
           var action = cmp.get("c.getConFiles");
           action.setParams({
                    "docId": hId
            });
        
            action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                //var ord = response.getReturnValue();
                //component.set("v.healthApp",ord); 
                cmp.set("v.contentList", response.getReturnValue());
                var cvList = response.getReturnValue();
                 cmp.set("v.contentDocId", cvList[0].ContentDocumentId); 
             }
            });

        $A.enqueueAction(action);
          
    },
    
    handleUploadFinished: function (cmp, event) {
        // Get the list of uploaded files
        var uploadedFiles = event.getParam("files");
        alert("Files uploaded : ");
        /*
        var hId = cmp.get("v.contentDocId");
        var action = cmp.get("c.updateFiles");
           action.setParams({
                    "appId": hId
            });
        
            action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                //var ord = response.getReturnValue();
                //component.set("v.healthApp",ord); 
                alert("Files uploaded : " + response.getReturnValue());
             }
            });

        $A.enqueueAction(action);
        */
    },
     handleRowAction: function (component, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        var ct = row;
        console.log(ct.ContentDocumentId);
        switch (action.name) {
            case 'Upload':
              component.set("v.contentDocId", ct.ContentDocumentId); 
              component.set("v.isFileOpen", true);
            break;
        }
     },
    closeModel: function(component, event, helper) {
        // for Close Model, set the "hasModalOpen" attribute to "FALSE"  
        component.set("v.isFileOpen", false);
        component.set("v.contentDocId" , null); 
        
        component.set("v.isContentOpen", false);
        
    },
    handleClick : function (cmp, event, helper) {
        //alert("You clicked: " + event.getSource().get("v.label"));
       cmp.set("v.isContentOpen", true);
    }
})