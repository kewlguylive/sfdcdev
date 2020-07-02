public class FileUploader {
@auraEnabled
public static String updateFile(String ContentDocumentId, String name, String et3AppName, String et3AppId, String uploadType){
        ContentVersion insCV = [SELECT Id, Title, VersionData, PathOnClient, Origin, ContentDocumentId  FROM ContentVersion WHERE ContentDocumentId = :ContentDocumentId AND IsLatest = true LIMIT 1];
        HealthApplication__c app = [SELECT Id FROM HealthApplication__c WHERE Id = :et3AppId LIMIT 1];
        if(insCV != null){
            if(uploadType == 'PA')insCV.Title = et3AppName+'_PA_'+name;
            else if(uploadType == 'NPP')insCV.Title = et3AppName+'NPP_Deliverable'+name;
            update insCV;

            if(app != null && uploadType == 'PA'){
                app.PA_Selected__c = true;
                update app;
            }else if(app != null && uploadType == 'NPP'){
                app.NPP_Selected__c = true;
                update app;
            }
               
             ContentVersion cv = [SELECT Id, ContentDocumentId  FROM ContentVersion WHERE ContentDocumentId = :ContentDocumentId AND IsLatest = true LIMIT 1];
             ContentWorkspace ws = [SELECT Id, RootContentFolderId FROM ContentWorkspace WHERE Name = 'HealthDocs' LIMIT 1];
                 
                 System.debug('Cv:'+cv.ContentDocumentId );
                
                ContentDocumentLink cdl = new ContentDocumentLink();
                cdl.ContentDocumentId = cv.ContentDocumentId;
                cdl.ShareType = 'I';
                cdl.Visibility = 'AllUsers';
                cdl.LinkedEntityId = ws.Id; //Magic happens here
                insert cdl;
                
            System.debug('CDL:'+cdl.Id);
           
    }
    return 'success';
}

}