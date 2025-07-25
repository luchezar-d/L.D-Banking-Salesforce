import { LightningElement } from 'lwc';
import signInTemplate from './signInTemplate.html';
import signUpTemplate from './signUpTemplate.html';
import renderMethod from './renderMethod.html';

export default class RenderMethod extends LightningElement {

    selectedBtn = '';

    render(){
        return this.selectedBtn === 'Sign up' ? signUpTemplate : 
                this.selectedBtn === 'Sign in' ? signInTemplate :
                this.selectedBtn === 'Back' ? renderMethod :
                renderMethod
        
    }

    handleClick(event){
        this.selectedBtn = event.target.label
    }

    submitHandler(event){
        console.log(`${event.target.label} successfully!`)
    }
}