import { LightningElement, wire } from 'lwc';
import showAccountsWithContacts from '@salesforce/apex/showAccountsWithContacts.showAccountsWithContacts'
export default class ShowAccountsWithContacts extends LightningElement {
    noAccounts = false
    accounts;
    @wire(showAccountsWithContacts)
    wiredAccounts({error, data}){
        if(data){
            this.accounts = data;
        }else if(error){
            console.error('Error fetching accounts:', error);
        }
    }
}