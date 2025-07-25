import { LightningElement } from 'lwc';

export default class Looping extends LightningElement {
    carList = ['audi','mercedes','bmw','ford','seat']

    ceoList = [
        {
            id: 1,
            company: 'google',
            name: 'pesho slepoto'
        },
        {
            id: 2,
            company: 'apple',
            name: 'pesho sakatoto'
        },
        {
            id: 3,
            company: 'facebook',
            name: 'pesho krivoto'
        },
        {
            id: 4,
            company: 'twitter',
            name: 'pesho groznoto'
        }
    ]
}