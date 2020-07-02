public class DailyLeadProcessor implements schedulable{
    
    public void execute(schedulableContext sc) {
        List<lead> newLeadList = new List<lead>();
        List<lead> ldLst = new List<lead>([select id, leadsource from lead where leadsource = null]);
        for(lead l : ldLst) {
            l.leadsource = 'Financialforce';
            newLeadList.add(l);
        }
        update newLeadList;
    }

}