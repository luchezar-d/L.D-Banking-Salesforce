trigger ProjectTrigger on Project__c (before insert,after insert, after update) {
    ProjectUtility utility = new ProjectUtility();
	if(Trigger.isAfter){
        List<Project__c> insertedRecords = (Project__c [])Trigger.new;
        
        List<Activity__c> activities = new List<Activity__c>();
           	List<Activity__c> activities2 = utility.createActivities(insertedRecords);
            activities.addAll(activities2);
        
            insert activities;
    }else if(Trigger.isAfter && Trigger.isUpdate){
        List<Project__c> insertedRecords = (Project__c [])Trigger.new;
        
        for(Project__c project : insertedRecords){
            utility.updateActivities(project);
        }
    }
}