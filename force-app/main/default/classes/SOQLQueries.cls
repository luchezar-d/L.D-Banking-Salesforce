public class SOQLQueries {
    public static List<Contact> getContacts(){
        List<Contact> conList = [SELECT Id,Firstname,Lastname,AccountId,Phone from Contact WHERE Phone != null Limit 5];
        system.debug(conList);
        return conList;
    }
    
public static List<Account> getAccountsWithTestObjects() {
    // Query Account records with related TestObject__c records
    List<Account> accList = [SELECT Id, Name
                             FROM Account 
                             WHERE Id IN (SELECT Account__c FROM TestObject__c WHERE Account__c != NULL)
                             LIMIT 2];

    // Check if there are any Account records
    if (!accList.isEmpty()) {
        // Iterate through Account records
        for (Account acc : accList) {
            // Debug Account fields
            System.debug('Account Name: ' + acc.Name);

            // You can optionally query additional fields from the TestObject__c records here if needed
            List<TestObject__c> relatedTestObjects = [SELECT Id, Name, Start_Date__c, End_Date__c
                                                      FROM TestObject__c
                                                      WHERE Account__c = :acc.Id];

            // Check if there are any related TestObject__c records
            if (!relatedTestObjects.isEmpty()) {
                // Iterate through related TestObject__c records
                for (TestObject__c testObject : relatedTestObjects) {
                    // Debug TestObject__c fields
                    System.debug('TestObject Name: ' + testObject.Name);
                    System.debug('TestObject Start Date: ' + testObject.Start_Date__c);
                    System.debug('TestObject End Date: ' + testObject.End_Date__c);
                }
            } else {
                System.debug('No related TestObject__c records for Account ' + acc.Name);
            }
        }
    } else {
        System.debug('No Account records found with related TestObject__c records.');
    }

    return accList;
}
    public static List<TestObject2__c> getTestObjects() {
        List<TestObject2__c> accList = [SELECT Name,TestObject__c,TestObject__r.Account__c,TestObject__r.Start_Date__c,TestObject__r.End_Date__c,
                                 (SELECT Name,CreatedById From TestObjects3__r)
                             FROM TestObject2__c LIMIT 2];
        system.debug(accList);
        return accList;
    }
    public static void getJohn() {
        List<List<sObject>> johnList = [Find 'testopp' returning Account(Id,Name),Contact(Id,Name,Lastname),Opportunity(id)];
        
        List<Opportunity> accList = johnList[2];
        for(Opportunity a : accList){
            system.debug(a);
        }
    }
}