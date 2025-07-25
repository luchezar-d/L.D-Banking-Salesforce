public with sharing class showAccountsWithContacts {
    @AuraEnabled(cacheable=true)
    public static List<Account> showAccountsWithContacts() {

        return [SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts WHERE (FirstName != null OR FirstName != '') AND (LastName != null OR LastName != '')) FROM Account LIMIT 5];

    }
}