import { LightningElement, wire } from 'lwc';
import {getRecord} from 'lightning/uiRecordApi'
import Id from '@salesforce/user/Id'

export default class WireDemoUserDetail extends LightningElement {
    userId = Id
    userDetails
    //0058K000003sMXsQAM

    @wire(getRecord, {recordId: '0058K000003sMXsQAM',fields:['User.Name','User.Email']})
    userDetailHandler({data,error}){
        if(data){
            this.userDetails = data.fields
        }

        if(error){
            console.log(error)
        }
    }
}