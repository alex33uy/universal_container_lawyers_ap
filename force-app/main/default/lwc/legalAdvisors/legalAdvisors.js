import { LightningElement, wire } from 'lwc';
import getLegalAdvisorsData from '@salesforce/apex/ucl_LegalAdvisors.getLegalAdvisorsData';

export default class LegalAdvisorsComponent extends LightningElement {
    legalAdvisors;
    error;

    @wire(getLegalAdvisorsData)
    wiredLegalAdvisors({ error, data }) {
        if (data) {
            this.legalAdvisors = data;
    
        } else if (error) {
            this.error = error;
            console.log('este es el error '+error)
        }
    }
}
