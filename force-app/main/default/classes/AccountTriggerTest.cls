@isTest
public class AccountTriggerTest {
 @isTest
    public static void test(){
        List<Account> accs = new List<Account>();
        
        for(integer i=0;i<200;i++){
            Account a  = new Account(BillingState = 'CA',Name = 'Gosho');
            accs.add(a);
        }
        
        Test.startTest();
        	insert accs;
        Test.stopTest();
        
        List<Account> newacc = [SELECT BillingState FROM Account WHERE BillingState = 'CA' Limit 200];
        
        System.assertEquals(200, newacc.size());
    }
}