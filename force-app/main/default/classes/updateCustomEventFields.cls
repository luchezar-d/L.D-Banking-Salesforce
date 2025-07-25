public class updateCustomEventFields {
    public static List<Custom_Event__c> updateFieldsMethod(String nameEvent){
        System.debug('Name of the event : ' + nameEvent);
        
        List<Custom_Event__c> customEventList = [SELECT id,Name 
                                                 FROM Custom_Event__c 
                                                 WHERE Name = :nameEvent];
        for(Custom_Event__c ce : customEventList){
            System.debug('Custom Event List ' + ' ' + ce);
        }
        return customEventList;
    }
    
    public static List<Event_Session__c> updateDate(Date startDate, Date endDate){
        
        List<Event_Session__c> EventSessionList = [SELECT id,Name,Start_Date__c,End_Date__c
                                                 FROM Event_Session__c ORDER BY Name];
        for(Event_Session__c es : EventSessionList){
            System.debug('custom event list ' + es);
            
            es.Start_Date__c = startDate;
            es.End_Date__c = endDate;
            
        }
        update eventSessionList;
        System.debug('EventSessionList : ' + eventSessionList);
        return EventSessionList;
    }
    
}