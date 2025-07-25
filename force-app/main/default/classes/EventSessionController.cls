public class EventSessionController {
    public static void createEventSessions(Date startDate, Date endDate, Integer listSize, String Id){
        List<Event_Session__c> sessions = new List<Event_Session__c>();
        
        for(Integer i = 0; i<listSize; i ++){
            Event_Session__c event = new Event_Session__c();
            event.Start_Date__c = startDate + i;
            event.End_Date__c = endDate + i;
            event.Custom_Event__c = Id;
            sessions.add(event);
        }
        insert sessions;
    }
    public static void createEventSession(Date startDate, Date endDate , String Id){
        Event_Session__c event = new Event_Session__c();
        event.Start_Date__c = startDate;
        event.End_Date__c = endDate;
        event.Custom_Event__c = Id;
        
        try{
           insert event; 
        }catch(DmlException e){
            System.debug('the exeption is' + e.getMessage());
        }
        
        
        
    }
    public static void updateSession(String Name, String sessionId){
        Event_Session__c se = [SELECT id,Name FROM Event_Session__c WHERE id = :sessionId];
        
        se.Name = Name;
        se.Id = sessionId;
        
        update se;
    }
    public static void getSessionWithMap(String Name){
        Map<String,Event_Session__c> myMap = new Map<String,Event_Session__c>([SELECT id, Name FROM Event_Session__c]);
        System.debug(' ' + myMap);
        List<Event_Session__c> sessions = myMap.values();
        
        for(Event_Session__c se : sessions){
            se.Name = Name;
        }
        update sessions;
        
    }
     public static void deleteSession(String sessionId){
        /*Event_Session__c se = [SELECT id,Name FROM Event_Session__c WHERE id = :sessionId];
        
        delete se;*/
        Map<String,Event_Session__c> myMap = new Map<String,Event_Session__c>([SELECT id, Name FROM Event_Session__c]);
        System.debug(' ' + myMap);
    }
     public static void undeleteSession(String sessionId){
        Event_Session__c se = [SELECT id,Name FROM Event_Session__c WHERE id = :sessionId];
        
        undelete se;
    }
}