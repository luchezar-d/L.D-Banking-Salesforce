@IsTest
public class AccountProcessorTest {
    @IsTest
    private static void testAccountProcess() {
        
        Account a = new Account(Name = 'John');
        insert a;
        
        Contact c1 = new Contact();
        c1.FirstName = 'John Contact 1';
        c1.LastName = 'Smith1';
        c1.AccountId = a.Id;
        insert c1;
        
        Contact c2 = new Contact();
        c2.FirstName = 'John Contact 2';
        c2.LastName = 'Smith2';
        c2.AccountId = a.Id;
        insert c2;
        
        List<Id> ids = new List<Id>();
        ids.add(a.Id);
        
        Test.startTest();
        AccountProcessor.countContacts(ids);
        Test.stopTest();
        
        Account accountToTest = [SELECT id,name,Number_of_Contacts__c FROM Account WHERE id =:a.Id LIMIT 1];
        
        System.assertEquals(2, Integer.valueOf(accountToTest.Number_of_Contacts__c));
    }
}