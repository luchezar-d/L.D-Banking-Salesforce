public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [
            SELECT Name, AnnualRevenue, Industry, Phone, Website
            FROM Account
            ORDER BY Name
            LIMIT 50
        ];
    }
    
    @AuraEnabled(cacheable=true)
    public static Account getAccountById(Id accountId) {
        return [
            SELECT Name, AnnualRevenue, Industry, Phone, Website, BillingCity, BillingState
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];
    }
}