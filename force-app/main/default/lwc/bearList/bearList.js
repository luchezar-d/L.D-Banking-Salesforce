import { LightningElement } from 'lwc';
import ursusResources from '@salesforce/resourceUrl/ursus_park';
import getAllBears from '@salesforce/apex/BearController.getAllBears';

export default class BearList extends LightningElement {
    bears;
    error;

    appResources = {
        bearSilhouette: `${ursusResources}/standing-bear-silhouette.png`,
    };

    connectedCallback(){
        this.loadAllBears();
    }

    loadAllBears(){
        getAllBears()
        .then(result => {
            this.bears = result;
        })
        .catch(error => {
            this.error = error;
        });
    }
}