@isTest
public class LeadProcessorTest {
    @testSetup
    static void setup(){
        List<Lead> leadsToInsert = new List<Lead>();
        
        for(integer i =0;i<200;i++){
            Lead l = new Lead(LastName='Random',Company='Random company');
            leadsToInsert.add(l);
        }
        insert leadsToInsert;
    }
    @isTest
    public static void test(){
        Test.startTest();
        LeadProcessor ls = new LeadProcessor();
        Id batchId = Database.executeBatch(ls);
        Test.stopTest();
        
        System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);
    }
}