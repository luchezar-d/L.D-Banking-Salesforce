public class CustomEventController {
    
    public List<Custom_Event__c> customEventsToCreate;
    public List<Event_Session__c> eventSessionsToCreate;
  
    public CustomEventController(){
        this.customEventsToCreate = new List<Custom_Event__c>();
        this.eventSessionsToCreate = new List<Event_Session__c>();
    }
    
    //creating custom event
    public Custom_Event__c createCustomEvent(Date startDate, Date endDate){
        Custom_Event__c ce = new Custom_Event__c(Start_Date__c = startDate, End_Date__c = endDate,Event_Subtype__c = 'Cars',Main_Event_Type__c='Sport');
        
        this.customEventsToCreate.add(ce);
        
        return ce;
    }
    
    public List<Event_Session__c> createEventSessions(Custom_Event__c ce){
        List<Event_Session__c> eventSessions = new List<Event_Session__c>();
        Date startDate = ce.Start_Date__c;
        Date endDate = ce.End_Date__c;
        
        if(startDate == null || endDate == null){
            return eventSessions;
        }
        
        Date currentDate = startDate;
        
        while(currentDate <= endDate){
            Event_Session__c es = new Event_Session__c();
            es.Start_Date__c = currentDate;
            es.End_Date__c = currentDate;
            es.Custom_Event__c = ce.Id;
            eventSessions.add(es);
            currentDate = currentDate.addDays(1);
        }
        
        return eventSessions;
    }
    
    public void insertRecords(){
        try{
            insert customEventsToCreate;
        }catch(DmlException e){
            System.debug('Error while inserting custom events: ' + e.getMessage());
        }
        
        for(Custom_Event__c ce : customEventsToCreate){
            List<Event_Session__c> esList = createEventSessions(ce);
            eventSessionsToCreate.addAll(esList);
        }
        
        try{
        	insert eventSessionsToCreate; 
        }catch(DmlException e){
            System.debug('Error while inserting event sessions: ' + e.getMessage());
        }
    }
    public void insertEventSessions(){
        
    }
    
    public static void updateCustomEvent(Date startDate, Date endDate, List<String> eventsId){
        List<Custom_Event__c> eventsToUpdate = [SELECT Start_Date__c,End_Date__c, Name FROM Custom_Event__c WHERE Id IN :eventsId];
        
        for(Custom_Event__c ce : eventsToUpdate){
            ce.End_Date__c = endDate;
            ce.Start_Date__c = startDate;
        }
        
        try{
            update eventsToUpdate;
        }catch(DmlException e){
            System.debug('OOPPPS');
        }
        
    }
    public static List<Custom_Event__C> createCustomEvents(Date startDate, Date endDate, Integer numEvents){
        List<Custom_Event__c> ceListTocreate = new List<Custom_Event__c>();
        
        for(Integer i = 0; i < numEvents; i ++){
            Custom_Event__c ce = new Custom_Event__c();
            ce.Start_Date__c = startDate.addDays(i);
            ce.End_Date__c = endDate.addDays(i);
            
            ce.Main_Event_Type__c = 'Sport';
            ce.Event_Subtype__c = 'Cars';
            
            ceListTocreate.add(ce);
            
        }
        
        System.debug('Custom events to be inserted : ' + ceListTocreate);
        return ceListTocreate;
    }
    public static void insertCustomEvents(List<Custom_Event__c> eventList){
        insert eventList;
    }
    public static void updateCustomEvents(List<Custom_Event__c> eventList){
        update eventList;
    }
    public static void upsertCustomEvents(List<Custom_Event__c> eventList){
        upsert eventList;
    }
    public static void deleteCustomEvents(List<Custom_Event__c> eventList){
        delete eventList;
    }
    public static List<Custom_Event__c> retrieveCustomEvents(Date startDate){
        List<Custom_Event__c> eventList = [SELECT Name,Start_Date__c, End_Date__c FROM Custom_Event__c WHERE Start_Date__c >:startDate];
        return eventList;
    }
}