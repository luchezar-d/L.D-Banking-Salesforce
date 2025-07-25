@isTest
public class CustomEventCreateEventSessions_test {
	@isTest
    public static void createEventSessionsTest(){
        CustomEventController controller = new CustomEventController();
        Custom_Event__c event = controller.createCustomEvent(Date.today(), Date.today().addDays(1));
        
        insert event;
        
        List<Event_Session__c> sessions = [SELECT Name,Id FROM Event_Session__c WHERE Custom_Event__c =: event.Id];
        
        System.assert(sessions.size() == 2);
    }
}