public with sharing class CampingListController {
	@AuraEnabled
    public static List<Camping_Item__c> getItems(){
        List<Camping_Item__c> campings = [SELECT Id,Name,Quantity__c,Price__c,Packed__c FROM Camping_Item__c];
        
        return campings;
    }
    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c camp){
        try{
            upsert camp;
            System.debug('good');
        }catch(DmlException e){
            System.debug('OOPPPS');
        }
        return camp;
    }
    @AuraEnabled
    public static void deleteItem(Camping_Item__c camp){
        try{
            delete camp;
        }catch(DmlException e){
            System.debug('OOPPPS');
        }
    }
    @AuraEnabled
    public static Camping_Item__c editItem(Camping_Item__c camp){
        try{
            upsert camp;
            System.debug('gavri');
        }catch(DmlException e){
            System.debug('OOPPPS');
        }
        return camp;
    }
    @AuraEnabled
    public static List<Camping_Item__c> getSearchItems(Camping_Item__c record){
        List<Camping_Item__c> campings = [SELECT Id,Name,Quantity__c,Price__c,Packed__c FROM Camping_Item__c WHERE Name =:record.Name];
        
        return campings;
    }
}