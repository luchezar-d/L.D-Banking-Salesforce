public class AccountProcessor {
    @future(callout=true)
    public static void countContacts(List<Id> accId){
        List<Contact> contacts = [SELECT id,name FROM Contact WHERE Account.id IN :accId];
        
        List<Account> accounts = [SELECT id,Number_of_Contacts__c FROM Account WHERE id IN :accId];
        
        for(Account a : accounts){
            a.Number_of_Contacts__c = contacts.size();
        }
        update accounts;
    }
}