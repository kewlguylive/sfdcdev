@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {  
    @HttpGet
    global static account getAccount() {        
        RestRequest request = RestContext.request;        
        String acctId = request.requestURI.substring(request.requestURI.lastIndexOf('/')-18,
                                                        request.requestURI.lastIndexOf('/'));
        List<Account> acts = [select id, name, (select id, name from contacts) from Account where id = :acctId];
        return acts[0];        
    }
    
}