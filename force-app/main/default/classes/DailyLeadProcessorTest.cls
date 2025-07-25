@isTest
public class DailyLeadProcessorTest {
    @isTest
    static void test(){
        
        List<lead> leads = new List<Lead>();
        for(integer i = 0;i<200;i++){
            Lead l = new Lead();
            l.LastName = 'joq';
            l.Company = 'Randoms';                
            leads.add(l);
        }
        insert leads;
        
        Map<Id,Lead> leadMap = new Map<Id,Lead>(leads);
        List<Id> leadIds = new List<Id>(leadMap.keySet());
        
        String CRON_EXP = '0 0 0 15 3 ? 2022';
        
        Test.startTest();
        	String jobId = System.schedule('Processor Leads',CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
        
        List<Lead> updatedLeads = [SELECT id,name FROM Lead WHERE id in : leadIds];
        
        System.assertEquals(200, updatedLeads.size());
    }
}