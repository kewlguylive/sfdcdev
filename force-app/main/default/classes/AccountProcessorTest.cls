@isTest
public class AccountProcessorTest {
    
    @isTest
    public static void testFunc() {
        account acc = new account();
        acc.name = 'RAHWAY INC';
        insert acc;
        
        contact con = new contact();
        con.lastname = 'Joel';
        con.AccountId = acc.Id;
        insert con;
        contact con1 = new contact();
        con1.lastname = 'Jockey';
        con1.AccountId = acc.Id;
        insert con1;
        
        
        List<Id> acclist = new List<Id>();
        acclist.add(acc.Id);
        Test.startTest();
          AccountProcessor.countContacts(acclist);
        Test.stopTest();
        List<account> acc1 = new List<account>([select Number_of_Contacts__c from account where id = :acc.id]);
        system.assertEquals(2,acc1[0].Number_of_Contacts__c);
    }

}