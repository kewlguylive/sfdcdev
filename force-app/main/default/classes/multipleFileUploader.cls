public class multipleFileUploader{


public multipleFileUploader(){

}

public void saveFiles(){

  String yourFiles = 'Lets assume this is your binary string of the files';
 
ContentVersion conVer = new ContentVersion();
conVer.ContentLocation = 'S'; // S specify this document is in SF, use E for external files
conVer.PathOnClient = 'ionicLogo.png'; // The files name, extension is very important here which will help the file in preview.
conVer.Title = 'Proposal '; // Display name of the files
conVer.VersionData = EncodingUtil.base64Decode(yourFiles); // converting your binary string to Blog
insert conVer;

// First get the content document Id from ContentVersion
Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
 
//Create ContentDocumentLink
ContentDocumentLink cDe = new ContentDocumentLink();
cDe.ContentDocumentId = conDoc;
//cDe.LinkedEntityId = yourObjectRecord.Id; // you can use objectId,GroupId etc
cDe.ShareType = 'I'; // Inferred permission, checkout description of ContentDocumentLink object for more details
cDe.Visibility = 'InternalUsers';
insert cDe;

}



}