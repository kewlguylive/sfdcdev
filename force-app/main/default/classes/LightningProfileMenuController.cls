public class LightningProfileMenuController {
    public LightningProfileMenuController() {

    }
    @AuraEnabled 
    public static user fetchUser(){
        return [Select id,Name From User Where Id =: Userinfo.getUserId()];
    }
    @AuraEnabled
    public static string getBaseURL(){
        String urlPrefix = '';
        if (Network.getNetworkId() != null) {
            urlPrefix = [SELECT Id, UrlPathPrefix FROM Network WHERE Id = :Network.getNetworkId()].UrlPathPrefix;
        }
        return URL.getSalesforceBaseUrl().toExternalForm()+'/'+urlPrefix;
    }
}