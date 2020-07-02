global without sharing class registerController {
@AuraEnabled
    public static String selfRegister(String email, String regConfirmUrl, String startUrl) {
        Savepoint sp = null;
        try {
            sp = Database.setSavepoint();
            
            if (email == null || String.isEmpty(email)) {
                return 'email req';
            }else if(!Pattern.matches('([a-zA-Z0-9_\\-\\.]+)@((\\[a-z]{1,3}\\.[a-z]{1,3}\\.[a-z]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})', email.trim())){
                 return 'Invalid email address. Please provide a valid email address.';
            }
            
            
         return RegisterUser( email.trim(), regConfirmUrl, startUrl);
        }
        catch (Exception ex) { //DML
            Database.rollback(sp);
            return ex.getMessage();            
        }
    }

    public static string RegisterUser(String email, String regConfirmUrl, String startUrl){
         String res = 'hello';
         List<String> lcs = new List<String>();
         lcs.add('test');
         
        //Id conRT = Schema.SObjectType.Contact.getRecordTypeInfosByName().get(et3Constants.RecordTypeName).getRecordTypeId();
        //Id linkedConRT = Schema.SObjectType.Linked_Contact__c.getRecordTypeInfosByName().get(et3Constants.RecordTypeName).getRecordTypeId();
        if(String.isNotBlank(res)){
            List<Contact> con = New List<Contact>([SELECT Id, firstname, lastname, email, accountId FROM Contact WHERE Email =:email]); //AND RecordTypeId =:conRT
            if(!con.IsEmpty()){
               // List<Linked_Contact__c> lcs = new List<Linked_Contact__c>([SELECT Id, Active__c FROM Linked_Contact__c WHERE Contact__c = :Con[0].Id AND Active__c = true AND RecordTypeId = :linkedConRT]);
                if(!lcs.IsEmpty()){
                    List<User> user = new List<User>([SELECT Id, IsActive, username FROM User WHERE ContactId =:con[0].Id]);
                    if(!user.IsEmpty()){
                       if(!user[0].IsActive){
                           user[0].IsActive = true;
                            update user[0];
                             System.enqueuejob(new assignPermSetandGroup(user[0].Id,'Health_Community_User',''));
                            return 'User has been activated and your username is '+ user[0].username+'. Please use forgot password page to request a new password.';
                       }else{
                            Boolean isUserExists = checkAssignedPermissionSet(user[0].Id,fetchPermissionSeteId('Health_Community_User'));
                            if(isUserExists){
                                 return 'user exists';
                            }
                            System.enqueuejob(new assignPermSetandGroup(user[0].Id,'Health_Community_User',''));
                            
                          }

                        if(String.isNotBlank(regConfirmUrl)){
                            ApexPages.PageReference confirmRef = new PageReference(regConfirmUrl);
                            aura.redirect(confirmRef);
                        }
                    }else{
                        return CreatePosrtaluser(con[0], regConfirmUrl, startUrl, 'Customer Community Custom', 'et3');
                    }
                    //common

                }else{
                     return 'NO Active Error';
                }
                
            }else{
                return 'No Error';
            }
           
        }else{
            return 'No record type found.';
        }

        return '';
    }


    public static String CreatePosrtaluser(contact contact, String regConfirmUrl, String startUrl, String ProfileName, String usernameExtension){
        
        User newPortalUser = new User();
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.EmailHeader.triggerUserEmail = false;
        newPortalUser.alias = 'standt';
        newPortalUser.emailencodingkey='UTF-8';
        newPortalUser.languagelocalekey='en_US';
        newPortalUser.localesidkey='en_US';
        newPortalUser.timezonesidkey='America/New_York';
        newPortalUser.email= contact.email;
        newPortalUser.lastname=contact.Lastname;
        newPortalUser.firstname = contact.firstname;
        newPortalUser.profileid = fetchProfileId(ProfileName);
        newPortalUser.contactId=contact.Id;
        newPortalUser.IsActive = true;
        if(String.isNotBlank(usernameExtension))newPortalUser.Username = contact.email+'.'+usernameExtension;
        else newPortalUser.Username = contact.email;
        newPortalUser.UserPermissionsSFContentUser=true;
        newPortalUser.setOptions(dmo);
        try{
            insert newPortalUser;
            String userId = newPortaluser.id;
            if(userId!=null){
                if(!test.Isrunningtest())
                System.enqueuejob(new assignPermSetandGroup(userid,'Health_Community_User',''));
            }
            if(String.isNotBlank(regConfirmUrl)){
                ApexPages.PageReference confirmRef = new PageReference(regConfirmUrl);
                aura.redirect(confirmRef);
            }
        }
        catch(DmlException ex){
            return 'Error: ' + ex.getMessage();
        }catch(Exception ex){
            return 'Error: ' + ex.getMessage();
        }
        
        return 'User created successfully.';
       
    }

    
    public static Boolean checkAssignedPermissionSet(Id userId, Id PermissionSetId){
        List<PermissionSetAssignment> PSAList = new List<PermissionSetAssignment>([select id from PermissionSetAssignment where PermissionSetId = :PermissionSetId and AssigneeId = :userId LIMIT 1]);
        if(!PSAList.IsEmpty()){
           return true;
        }
        return false;
    }
    
    public static Id fetchProfileId(String ProfileName){
        List<Profile> targetProfile = new List<Profile>([Select name, id From Profile where Name =: ProfileName limit 1]);
        if(!targetProfile.IsEmpty())return targetProfile[0].Id;
        else return null;
    }

    public static Id fetchPermissionSeteId(String PermissionSetName){
        List<PermissionSet> targetPermission = new List<PermissionSet>([Select name, id From PermissionSet where Name =: PermissionSetName limit 1]);
        if(!targetPermission.IsEmpty())return targetPermission[0].Id;
        else return null;
    }  
}