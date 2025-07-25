trigger CustomEventTrigger on Custom_Event__c (before insert,after insert,after update) {
    
    Boolean isInsert = Trigger.isInsert;
    
    if(Trigger.isAfter){
        List<Custom_Event__c> insertedRecords = (Custom_Event__c [])Trigger.new;
        CustomEventController controller = new CustomEventController();
        List<Event_Session__c> sessions = new List<Event_Session__c>();
        for(Custom_Event__c ce : insertedRecords){
            
            //Event_Session__c ses = new Event_Session__c();
           	List<Event_Session__c> sessions2 = controller.createEventSessions(ce);
            sessions.addAll(sessions2);
            //sessions.addAll(controller.createEventSessions(ce));
        }
        
        try{
            insert sessions;
        }catch(DmlException e){
            
        }
    }
    
    /*if(Trigger.isBefore){
        List<Custom_Event__c> insertedRecords = (Custom_Event__c [])Trigger.new;
        
        for(Custom_Event__c ce : insertedRecords){
            //ce.Start_Date__c = Date.today();
            ce.Name = 'WTFFFF';
            if(ce.Start_Date__c != ce.End_Date__c){
                ce.End_Date__c = ce.Start_Date__c;
            }
        }
    }*/
    
    if(isInsert && Trigger.isBefore){
        
        List<Custom_Event__c> insertedRecords = (Custom_Event__c [])Trigger.new;
        
        for(Custom_Event__c ce : insertedRecords){
            //ce.Start_Date__c = Date.today();
            if(ce.Start_Date__c != null && ce.End_Date__c == null){
                ce.End_Date__c = ce.Start_Date__c;
            }
        }
        
        System.debug('### My object ' + ' ' + Trigger.new);
        
    }
}