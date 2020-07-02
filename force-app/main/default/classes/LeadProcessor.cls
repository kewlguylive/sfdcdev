global class LeadProcessor implements Database.Batchable<sObject> {
    global Integer count = 0;
    
    global Database.QueryLocator start (Database.BatchableContext bc) {
        return Database.getQueryLocator('Select Id, LeadSource from lead');
    }
    
    global void execute (Database.BatchableContext bc,List<Lead> scope) {
       
       List<lead> leadLst = new List<lead>();
        
        for(lead l : scope) {
            l.leadsource = 'Financialforce';
            leadLst.add(l);
            count+=1;
        }
        update leadLst;
    }
    
    global void finish (Database.BatchableContext bc) {
        
    }
}