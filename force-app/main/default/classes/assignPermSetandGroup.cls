public class assignPermSetandGroup {
//Assigns user to a Permission Set, and optionally also to a Group
    string Userid;
    String PermsetName;
    String GroupName;
    Boolean isAssign;
    Set<Id> Userids;
    
    public assignPermSetandGroup (id Userid,string PermsetName,string groupname){
        this.Userid = Userid;
        this.permsetname = permsetName;
        this.groupName=groupname;
        this.isAssign = true;
        this.Userids = new Set<id>();
    }
    
    public assignPermSetandGroup (id Userid,string PermsetName,string groupname,boolean isAssign){
        this.Userid = Userid;
        this.permsetname = permsetName;
        this.groupName=groupname;
        this.isAssign = isAssign;
        this.Userids = new Set<id>();
    }

    public assignPermSetandGroup (Set<id> Userids,string PermsetName,string groupname,boolean isAssign){
        this.Userids = Userids;
        this.permsetname = permsetName;
        this.groupName=groupname;
        this.isAssign = isAssign;
    }

    public void execute(QueueableContext context){
        processInput();
        
    }
    
    public void processInput() {
        system.debug('Userids ='+Userids);
        List<PermissionSet> PS = [select id,name from PermissionSet where Name=:PermsetName LIMIT 1];
        
        //Assign or remove permission set membership
        if (PS.size() == 1) {
            
            if (isAssign) {
                PermissionSetAssignment PSA = new PermissionSetAssignment();
                PSA.PermissionSetId=PS[0].id;
                PSA.AssigneeId=userid;
                //insert PSA - ignore exceptions since it generally means it's a duplicate PSA, which is not really a problem
                Database.Saveresult s = database.insert(PSA, false);
                
            } else {
                 List<PermissionSetAssignment> PSAList = new  List<PermissionSetAssignment>();
                if(Userids.size() > 0) {
                    PSAList = [select id from PermissionSetAssignment where PermissionSetId = :PS[0].id and AssigneeId IN :Userids];
                      system.debug('PSAList ='+PSAList);
                    if (PSAList.size() > 0) {
                    List<Database.DeleteResult> drs = database.delete(PSAList, false);
                    }
                }
                else{
                    PSAList = [select id from PermissionSetAssignment where PermissionSetId = :PS[0].id and AssigneeId = :userid LIMIT 1];
                    if (PSAList.size() == 1) {
                        Database.DeleteResult dr = database.delete(PSAList[0], false);
                    }
                }
            }
        }
        
        //Assign ore remove group membership if specified
        if(!string.isblank(groupname) && !test.isrunningtest() ){
           // System.enqueueJob(new AssignGroupMember(Userid,groupname,isAssign));
        }
        
    }
}