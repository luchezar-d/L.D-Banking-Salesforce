public with sharing class ContactController {
    @AuraEnabled(cacheable = true)
        public static List<Contact> getContacts(){
            return [SELECT FirstName,LastName,Email FROM Contact WHERE Phone != null ORDER BY FirstName limit 5];
            //throw new AuraHandledException('Forced error');
        }
    
    public static List<Contact> findAll(){
        return [Select Name, phone from Contact Limit 50];
    }
    
    public static List<Contact> findByName(String searchKey){
        String name = '%'+searchKey+'%';
        
        return [Select Name, phone from Contact where Name like :name Limit 50];
    }
    
    public static Contact findById(String contactId){
        return [Select Id,Name,title,phone,mobilephone,Account.Name from Contact where Id = :contactId Limit 1];
    }
}