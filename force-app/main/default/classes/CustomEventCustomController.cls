public with sharing class CustomEventCustomController {
    @AuraEnabled
    public static List<Custom_Event__c> getEvents(){
        List<Custom_Event__c> events = [SELECT id,Name,Start_Date__c,End_Date__c,Price__c,Discount__c FROM Custom_Event__c];
        
        return events;
    }
}