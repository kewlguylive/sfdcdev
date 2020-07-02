trigger contentTrigger on ContentVersion (after insert, after update, before insert, before update) {
  if(Trigger.isBefore && Trigger.isInsert){
      contentTriggerHandler ct = new contentTriggerHandler();
      ct.onBeforeInsert(Trigger.new, Trigger.newMap,trigger.Oldmap);
  }else if(Trigger.isAfter && Trigger.isInsert){
      contentTriggerHandler ct = new contentTriggerHandler();
      ct.onAfterInsert(Trigger.new, Trigger.newMap,trigger.Oldmap); 
  }else if(Trigger.isBefore && Trigger.isUpdate){
      contentTriggerHandler ct = new contentTriggerHandler();
      ct.onBeforeUpdate(Trigger.new, Trigger.newMap,trigger.Oldmap);
  }
    
}