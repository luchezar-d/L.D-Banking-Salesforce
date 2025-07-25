@isTest
public class ProjectUtility_test {
    @isTest
    public static void testActivities(){
        ProjectUtility utilit = new ProjectUtility();
    	Project__c project = new Project__c();
    	project.Start_Date__c = Date.today();
    	project.Start_Date__c = Date.today().addDays(4);
    
        insert project;
        
        List<Activity__c> activities = [SELECT iD,Name FROM Activity__c WHERE Project__c =: project.Id];
    }
}