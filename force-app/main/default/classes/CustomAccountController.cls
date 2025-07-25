public with sharing class CustomAccountController {
	@AuraEnabled
    
    public static Account getAccount(){
        Account a = [SELECT id,name FROM Account WHERE Name = 'Asparuh2'];
        System.debug('Account is :' + a);
        return a;
        
    }
}