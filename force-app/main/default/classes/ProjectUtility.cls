public class ProjectUtility {
    
	public List<Project__c> customProjectsToCreate;
    public List<Activity__c> customActivitiesToCreate;
    
    public ProjectUtility(){
        customProjectsToCreate = new List<Project__c>();
        customActivitiesToCreate = new List<Activity__c>();
    }
    
    public List<Activity__c> createActivities(List<Project__c> projects){
       	List<Activity__c> activities = new List<Activity__c>();
        
        for(Project__c project : projects){
            
            Date startDate = project.Start_Date__c;
        	Date endDate = project.End_Date__c;
            
            Date currentDate = startDate;
        
        while(currentDate <= endDate){
            Activity__c ac = new Activity__c();
            ac.Start_Date__c = currentDate;
            ac.End_Date__c = currentDate;
            ac.Project__c = project.Id;
            activities.add(ac);
            currentDate = currentDate.addDays(1);
        }
        }
        
        return activities;
    }
    public List<Activity__c> updateActivities(Project__c project){
        List<Activity__c> activitiesToUpdate = [SELECT id,Name,End_Date__c,Start_Date__c FROM Activity__c WHERE Project__c =: project.Id];
        
        List<Activity__c> activities = new List<Activity__c>();
        
        Activity__c lastActivity = activitiesToUpdate.get(activitiesToUpdate.size() - 1);
        
        if(project.End_Date__c >= lastActivity.End_Date__c){
            Date CurrentDate = lastActivity.End_Date__c.addDays(1);
            while(CurrentDate < project.End_Date__c){
                Activity__c activity = new Activity__c();
                activity.Start_Date__c = project.Start_Date__c;
                activity.End_Date__c = project.End_Date__c;
                activity.Id = project.Id;
                activities.add(activity);
                
                CurrentDate = lastActivity.End_Date__c.addDAys(1);
            }
            insert activities;
        }
        
        if(project.Start_Date__c < lastActivity.Start_Date__c){
            Date CurrentDate = lastActivity.Start_Date__c.addDays(1);
            while(CurrentDate > project.Start_Date__c){
                Activity__c activity = new Activity__c();
                activity.Start_Date__c = project.Start_Date__c;
                activity.End_Date__c = project.End_Date__c;
                activity.Project__c = project.id;
                activitiesToUpdate.add(activity);
                
                CurrentDate = lastActivity.Start_Date__c.addDays(1);
            }
        }
        
        return activitiesToUpdate;
    }
    public List<Activity__c> deleteActivities(Project__c project){
        List<Activity__c> activitiesToDelete = [SELECT id,Name FROM Activity__c WHERE Project__c =: project.Id];
        
        Activity__c lastActivity = activitiesToDelete.get(activitiesToDelete.size() - 1);
        List<Activity__c> activities = new List<Activity__c>();
        
        if(project.End_Date__c <= lastActivity.End_Date__c){
            Date CurrentDate = lastActivity.End_Date__c.addDays(1);
            while(CurrentDate > project.End_Date__c){
                for(Integer i = 0; i < activitiesToDelete.size(); i++){
                    activitiesToDelete.remove(i);
                }
            }
        }
        
        return activitiesToDelete;
    }    
}