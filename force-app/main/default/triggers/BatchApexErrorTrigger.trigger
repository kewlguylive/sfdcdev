trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
  list<BatchLeadConvertErrors__c> lstBatchData = new list<BatchLeadConvertErrors__c>();
    for(BatchApexErrorEvent logData:trigger.new){
      BatchLeadConvertErrors__c newBatchTest = new BatchLeadConvertErrors__c();
       newBatchTest.AsyncApexJobId__c = logData.AsyncApexJobId;
       newBatchTest.Records__c =  logData.JobScope;
       newBatchTest.StackTrace__c =  logData.StackTrace;
       lstBatchData.add(newBatchTest);
    }
    insert lstBatchData;
}