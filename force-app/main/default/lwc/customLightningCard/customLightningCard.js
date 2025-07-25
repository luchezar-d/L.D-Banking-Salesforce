import { LightningElement } from 'lwc';

export default class CustomLightningCard extends LightningElement {
    handleFooter(){
        const footerTemplate = this.template.querySelector('footer')
        if(footerTemplate){
            footerTemplate.classList.remove('slds-hide')
        }
    }
}