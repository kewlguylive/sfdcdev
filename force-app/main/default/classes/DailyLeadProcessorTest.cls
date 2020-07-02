@isTest
public class DailyLeadProcessorTest {
    
    @isTest
    public static void testing() {
        
        List<lead> ledLst = new List<lead>();
        
        for(Integer i=0;i<200;i++) {
            lead l = new lead();
            l.Company = 'company'+i;
            l.lastname = 'lastname'+i;
            ledLst.add(l);
        }
        insert ledLst;
        
        Test.startTest();
        DailyLeadProcessor dlp = new DailyLeadProcessor ();
        String jobId = System.Schedule('dailyleadprocessing','0 0 0 10 9 ? 2019',dlp);
        Test.stopTest();
        
        List<lead> chkLeads = new List<lead>([select id,leadsource from lead where leadsource != 'Financialforce']);
        System.assertequals(0,chkLeads.size());
    }

}