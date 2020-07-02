public class AddPrimaryContact implements Queueable {
    public contact c;
    public String state;
    
    public AddPrimaryContact(Contact c, String state) {
        this.c = c;
        this.state = state;
    }
    
    public void execute(QueueableContext qc) {
        //test comment
        List<Account> actList = new List<account>([select id, name, BillingState from account where account.BillingState = :this.state limit 200]);
        List<contact> conlst = new List<contact>();
        for(account a: actList) {
            contact c = new contact();
            c = this.c.clone(false, false, false, false);
            c.AccountId = a.Id;
            conlst.add(c);
        }
        insert conlst;
    }

}