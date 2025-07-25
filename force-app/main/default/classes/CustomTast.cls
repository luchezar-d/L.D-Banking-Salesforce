public class CustomTast {
	public static void createCustomEvent(Date startDate, Date endDate){
        Custom_Event__c ce = new Custom_Event__c();
        
        ce.Start_Date__c = startDate;
        ce.End_Date__c = endDate;
        
        ce.Main_Event_Type__c = 'Sport';
        ce.Event_Subtype__c = 'Cars';
        
        insert ce;
        System.debug('Id : ' + ' ' + ce.Id);
    }
    public static void createEventSession(){
        List<Custom_Event__c> customEvents = [SELECT id,Name,Start_Date__c, End_Date__c FROM Custom_Event__c];
        
        for(Custom_Event__c ce : customEvents){
            List<Event_Session__c> sessions = new List<Event_Session__c>();
			for(Integer i = 0 ; i <= ce.Start_Date__c.daysBetween(ce.End_Date__c); i++){
            Event_Session__c customSession = new Event_Session__c();
            
                customSession.Start_Date__c = ce.Start_Date__c + i;
                customSession.End_Date__c = ce.End_Date__c + i;
                customSession.Custom_Event__c = ce.Id;
               	sessions.add(customSession);
        	}  
            insert sessions;
        }
    }
}