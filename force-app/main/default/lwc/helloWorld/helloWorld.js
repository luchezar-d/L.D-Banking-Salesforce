import { LightningElement,track } from 'lwc';

export default class HelloWorld extends LightningElement {
    title = '';
    changeHandler(event){
        this.title = event.target.value;
    }
    @track
    address={
        city:'Melbourne',
        postCode: 5000,
        country:'Australia'
    }

    trackHandler(event){
        this.address = {...this.address, 'city':event.target.value};
    }

    users = ['pesho','gosho']

    num1 = 1;
    num2 = 2;

    get firstUser(){
        return this.users[0]
    }

    get result(){
        return this.num1+ this.num2;
    }
}