@IsTest
public class AddPrimaryContactTest {
    
    @IsTest
    public static void testingContact() {
        List<account> acclst = new List<account>();
        for (Integer i=0; i<50;i++) {
            account a = new account(name=string.valueOf(i),billingstate='MD');
            acclst.add(a);
        }
        for (Integer i=0; i<50;i++) {
            account a = new account(name=string.valueOf(50+i),billingstate='CA');
            acclst.add(a);
        }      
        insert acclst;
        Test.startTest();
        contact c = new contact(lastname='karoun');
        AddPrimaryContact apryc = new AddPrimaryContact(c,'CA');
        System.enqueueJob(apryc);
        Test.stopTest();
        List<contact> conlst = new List<contact>([select id from contact]);
        Integer size = conlst.size();
        system.assertEquals(50, size);
    }

}