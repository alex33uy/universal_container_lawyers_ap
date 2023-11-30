import { LightningElement, wire } from 'lwc';
import showLegalAdvisorData from '@salesforce/apex/ucl_QueryData.showLegalAdvisorData';

export default class LegalAdvisorsComponent extends LightningElement {

    @wire(showLegalAdvisorData)
    wiredLegalAdvisors({ error, data }) {
        if (data) {
            this.legalAdvisors = data;
    
        } else if (error) {
            this.error = error;
            console.log('este es el error '+error)
        }
    }
}
