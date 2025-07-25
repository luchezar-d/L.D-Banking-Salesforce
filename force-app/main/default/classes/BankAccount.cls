public class BankAccount {
	public String accName;
    public String accType;
    private Integer balance = 0;
    
    public void makeDeposite(Integer deposit){
        balance += deposit;
    }
    public Integer getBalance(){
        return balance;
    }
    
    
    
}