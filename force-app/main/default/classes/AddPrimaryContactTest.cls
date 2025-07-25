@isTest
public class AddPrimaryContactTest {
	@testSetup
    static void setup(){
        List<Account> accs = new List<Account>();
        
        for(integer i =0;i<50;i++){
            Account a = new Account();
            a.BillingState = 'CA';
            a.name = 'Test' + i;
            accs.add(a);
        }
        for(integer i =0;i<50;i++){
            Account b = new Account();
            b.BillingState = 'CA';
            b.name = 'Test' + i;
            accs.add(b);
        }
        
        insert accs;
        
        Contact c = new Contact();
        c.FirstName = 'Cont';
        c.LastName = 'Contt';
        insert c;        
    }
    
    static testmethod void testQueueable(){
        String state = 'CA';
        Contact c = [SELECT id,LastName FROM Contact Where LastName='Contt' Limit 1];
        AddPrimaryContact apc = new AddPrimaryContact(c, state);
        Test.startTest();
        System.enqueueJob(apc);
        Test.stopTest();
    }
}