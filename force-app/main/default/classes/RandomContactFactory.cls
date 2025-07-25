public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer contactNum,String lastName){
        List<Contact> contacts = new List<Contact>();
        
        for(Integer i=0;i<contactNum;i++){
            Contact con = new Contact();
            con.FirstName = 'Random' + i;
            con.LastName = lastName;
            
            contacts.add(con);
        }
        
        return contacts;
    }
}