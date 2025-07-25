global class ProcessEventSessionBatch implements Database.Batchable<sObject>{
	
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        String query = 'SELECT id,Name,Processed__c FROM Event_Session__c';
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<sObject> recordsList){
        List<Event_Session__c> sessions = new List<Event_Session__c>();
        
        for(sObject ob : recordsList){
            Event_Session__c session = (Event_Session__c) ob;
            session.Processed__c = true;
            session.Name = 'my name';
            
            sessions.add(session);
        }
        update sessions;
    }
    
    global void finish(Database.BatchableContext bc){
        
    }
}