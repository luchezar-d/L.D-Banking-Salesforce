import { LightningElement, wire, api } from 'lwc';
import getContacts from '@salesforce/apex/GetRelatedContacts.getRelatedContactsFromAcc';

export default class RelatedContacts extends LightningElement {

    @wire(getContacts, {accountId : '0016g00001ohfvrAAA'})
    contacts;
}