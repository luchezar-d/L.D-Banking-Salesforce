import { LightningElement,api } from 'lwc';

export default class SlotDemoChild extends LightningElement {
    handleFooterChange(){
        const footerElement = this.template.querySelector('.slds-card__footer')
        if (footerElement){
            footerElement.classList.remove('slds-hide')
        }
    }
}