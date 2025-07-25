public with sharing class GetRelatedContacts {
    @AuraEnabled(cacheable = true)
    public static List<Contact> getRelatedContactsFromAcc(String accountId){
        System.debug('Received Account Id: ' + accountId);
        List<Contact> contacts = [SELECT Id, FirstName, LastName, Phone, Email, Name FROM Contact WHERE Email != null AND Email != '' AND AccountId = :accountId ORDER BY FirstName LIMIT 5];
        System.debug('Number of contacts returned: ' + contacts.size());
        return contacts;
    }
}