@Istest(SeeAllData=true)
public class AccountManagerTest {
    @IsTest
    public static void testaccountmanager() {
        Account acct = new Account(Name = 'Test');
        insert acct;
        Contact con = new Contact(FirstName = 'Test', LastName = 'Test');
        con.AccountId = acct.Id;
        insert con;
        RestRequest request = new RestRequest();
        request.requestUri = 'https://preetham-dev-ed.my.salesforce.com/services/apexrest/Accounts/'+acct.Id+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account retAcc = AccountManager.getAccount();
        System.assert('Test' == retAcc.Name);
        System.assert(1 == retAcc.contacts.size());
    }
}