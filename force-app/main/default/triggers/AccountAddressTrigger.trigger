trigger AccountAddressTrigger on Account (before insert,before update) {
    List<Account> accounts = Trigger.new;
    
    for(Account a : accounts){
        if(a.Match_Billing_Address__c == true && a.BillingPostalCode != null){
            a.ShippingPostalCode = a.BillingPostalCode;
        }
    }
}