import { LightningElement,api } from 'lwc';

export default class SetterDemoChild extends LightningElement {
    userDetail
    location = 'Melburn'
    @api
    get detail(){
        return this.userDetail
    }

    set detail(data){
        let newAge = data.age * 2
        this.userDetail = {...data, age: newAge, location: this.location}
    }
}