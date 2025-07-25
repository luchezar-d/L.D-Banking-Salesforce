public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String leadOrCont){
        
        List<List<sObject>> searchList = [FIND :leadOrCont IN ALL FIELDS 
                   RETURNING Lead(FirstName,LastName),Contact(FirstName,LastName)];
        
        return searchList;
    }
}