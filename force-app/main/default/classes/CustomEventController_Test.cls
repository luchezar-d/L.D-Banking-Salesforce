@isTest
public class CustomEventController_Test {
    
    @isTest
    public static void testCreateCustomEvent(){
        CustomEventController cec = new CustomEventController();
        Date startDate = Date.today();
        Date endDate = Date.today().addDays(5);
        
        cec.createCustomEvent(startDate, startDate);
        cec.insertRecords();
        
        Integer CustomEventsNumber = [SELECT COUNT() FROM Custom_Event__c];
        
        System.assert(CustomEventsNumber == 1);
        System.assertEquals(CustomEventsNumber, 1);
        System.assertNotEquals(CustomEventsNumber, 0);
    }
    
    @isTest
    public static void testCreateCustomEventForKO(){
        CustomEventController cec = new CustomEventController();
        cec.createCustomEvent(null,null);
        cec.insertRecords();
        Integer CustomEventsNumber;
        try{
            CustomEventsNumber = [SELECT COUNT() FROM Custom_Event__c];
        }catch(Exception ex){
            CustomEventsNumber = 0;
        }
        
        System.assert(CustomEventsNumber == 1);
        System.assertEquals(CustomEventsNumber, 1);
        System.assertNotEquals(CustomEventsNumber, 0);
    }
}