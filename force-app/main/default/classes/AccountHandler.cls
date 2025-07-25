public class AccountHandler {
    public Account insertNewAccount(String accName){
        Account acct = new Account(
            	Name = accName
            );
        try {
            insert acct;
        }catch(Exception e){
            return null;
        }
        System.debug('new account is: ' + acct);
        return acct;
        
    }
}