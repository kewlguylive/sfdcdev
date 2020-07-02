public class AccountProcessor {
    @future
    public static void countContacts(List<Id> actIds) {
        Map<Id,Integer> accountconMap = new Map<Id,Integer>();
        List<account> actAll = new List<account>([select id, (select id from contacts) from account]);
        for(account a: actAll) {
            accountconMap.put(a.id,a.contacts.size()); 
        }
        List<account> accountlst = new List<account>();   
        for(Id accountId : actIds) {
            if(accountconMap.containsKey(accountId)) {
                account acc = new account();
                acc.Id = accountId;
                acc.Number_of_Contacts__c = accountconMap.get(accountId);
                accountlst.add(acc);} 
        }
        upsert accountlst;
    }
}