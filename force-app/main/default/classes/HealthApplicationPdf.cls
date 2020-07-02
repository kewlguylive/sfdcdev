public class HealthApplicationPdf {

public String haFormId {get; set;}
public HealthApplication__c haForm {get; set;}

public HealthApplicationPdf() {
        this.haForm = new HealthApplication__c();
        this.init();
    }
    
    
    
    public void init() {    
    
      List<HealthApplication__c>  hApps = [select Id, Account_Name__c, Applicant__c, Name__c, NPP_Selected__c, OptOut__c, PA_Selected__c, State__c from HealthApplication__c];
      
          if(hApps.size() >0){
            for(HealthApplication__c hap: hApps){
              Id recordId = hap.Id;
              PageReference pdfPage = new PageReference('/apex/HealthApplicationPdfVF?Id='+recordId);
              haForm = hap;
              
               string fileName = 'My PDF Report '+hap.Name__c+'.pdf';
               
              // Apexpages.currentPage = pdfPage;
                //here is were the magic happens. We have to set the content disposition as attachment.
                Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename='+fileName);
              
            }
            //PageReference pdfPage = new PageReference('/apex/HealthApplicationPdfVF?Id='+recordId);
          
          
          }
    
          //haFormId = Apexpages.currentPage().getParameters().get('id');
         // haForm = [select Id, Account_Name__c, Applicant__c, Name__c, NPP_Selected__c, OptOut__c, PA_Selected__c, State__c from HealthApplication__c where Id =: haFormId];
    
       //setup a default file name
                //string fileName = 'My PDF Report '+date.today()+'.pdf';
                //here is were the magic happens. We have to set the content disposition as attachment.
              //  Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename='+fileName);
    
    }
    
    
}