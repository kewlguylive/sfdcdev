({
    init : function(component, event, helper) {
         component.set("v.appId","a0FB0000003TSV5");
    },
	handleUploadFinished: function (component, event) {
        // Gd files
        var uploadedFiles = event.getParam("files");
        alert("Files uploaded : ");
        
         component.set("v.appName","Health");
         component.set("v.uploadType","PA");
       console.log('test1');
        var action = component.get("c.updateFile");
        action.setParams({ ContentDocumentId: uploadedFiles[0].documentId, name:uploadedFiles[0].name, et3AppName: component.get("v.appName"), et3AppId: component.get("v.appId"),uploadType:component.get("v.uploadType")});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                alert("Files uploaded : ");
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": 'File uploaded successfully.',
                    "type" : "success"
                });
                toastEvent.fire();
            }else if (state === "INCOMPLETE") {
                console.log('INCOMPLETE');
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "Error!",
                            "message":  errors[0].message,
                            "type" : "error"
                        });
                        toastEvent.fire();
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });

        $A.enqueueAction(action);

    }
})