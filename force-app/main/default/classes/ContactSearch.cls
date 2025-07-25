public class ContactSearch {
    public static List<Contact> searchForContacts(String lastName,String mailingPostalCode){
        List<Contact> contacts = [SELECT id,Name FROM CONTACT WHERE (CONTACT.LASTNAME =:lastname AND CONTACT.MAILINGPOSTALCODE =:mailingPostalCode)];
        
        return contacts;
    }
}