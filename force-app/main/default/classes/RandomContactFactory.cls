public class RandomContactFactory {
public static List<Contact> generateRandomContacts(Integer numberOfContacts, String lastName) {	  
    List<Contact> conList = new List<Contact>();	       
    for(Integer i=0; i<numberOfContacts; i++) {	          
        Contact c = new Contact(Firstname = 'Test' + i, Lastname = lastName);	        
        conList.add(c);	        }	  
    return conList;	    }
}