public class AddPrimaryContact implements Queueable{
    
    private Contact c;
    private String state;
    
    public AddPrimaryContact(Contact c, String state){
        this.c = c;
        this.state = state;
    }
    
    public void execute(QueueableContext context){
        List<Account> accounts = [SELECT BillingState FROM Account Where BillingState =:state LIMIT 200];
        List<Contact> contsToInsert = new List<Contact>();
        
        for(Account a : accounts){
            Contact cont = c.clone(false,false,false,false);
            cont.AccountId = a.id;
            contsToInsert.add(cont);
        }
        insert contsToInsert;
    }
}