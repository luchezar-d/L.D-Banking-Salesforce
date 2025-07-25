import { LightningElement } from 'lwc';

export default class HelloQuerySelectorDemo extends LightningElement {
    userNames = ['John','Smith','Pesho','Gosho']

    fetchDetailsHandler(){

        const elem = this.template.querySelector('h1');
        elem.style.border = '2px solid red'
        console.log(elem.innerText)

        const userElements = this.template.querySelectorAll('.name')
        
        Array.from(userElements).forEach(item => {
            item.setAttribute('title',item.innerText)
            console.log(item.innerText)
        });

        const childElem = this.template.querySelector('.child')
        childElem.innerHTML = '<p>Hey waths ap </p>'
    }
}