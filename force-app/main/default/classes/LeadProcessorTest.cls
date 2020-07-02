@isTest
public class LeadProcessorTest {
    
    @isTest    
    public static void testLeads() {
        List<lead> ldLst = new List<lead>();
        for (Integer i = 0; i<200; i++) {
            Lead l = new lead();
            l.LastName = 'Inc'+i;
            l.company = 'Dcompany';
            l.LeadSource ='Financialforce';
            l.Status =  'Working-Contacted';
            ldLst.add(l);
        }
        insert ldLst;
        
        test.startTest();
        
        Leadprocessor lp = new Leadprocessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
            
    }

}