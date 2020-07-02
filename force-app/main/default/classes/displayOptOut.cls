public class displayOptOut {

    
    public HealthApplication__c hApp {set;get;}
    public String selOption {get;set;}

    public displayOptOut() {
       // hApp = [select id,Name, OptOut__c from HealthApplication__c where id =: ApexPages.currentPage().getParameters().get('id')];
        hApp =  [select id,Name, OptOut__c from HealthApplication__c where id = 'a0FB0000003TSV5'];
    }
    
    public HealthApplication__c gethApp() {
        return hApp;
    }
    
    public PageReference setOptOut(){
       hApp.OptOut__c = selOption;
       //update hApp;
       return null;
    
    }
    
    public List<SelectOption> regions
    {
     get
     {
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = HealthApplication__c.OptOut__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();

        for( Schema.PicklistEntry f : ple)
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        return options;
     }
   }

    public PageReference save() {
        update hApp;
        PageReference pref = new ApexPages.StandardController(hApp).view();
        return pref;
    }
}