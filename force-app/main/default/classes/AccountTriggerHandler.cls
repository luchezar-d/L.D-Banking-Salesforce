public class AccountTriggerHandler {
    public static void CreateAccounts(List<Account> accs){
        for(Account a : accs){
            if(a.ShippingState != a.BillingState){
                a.ShippingState = a.BillingState;
            }
        }
    }
}