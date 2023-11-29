import { LightningElement, wire } from 'lwc';
import getLegalAdvisorsData  from '@salesforce/apex/ucl_LegalAdvisors.getLegalAdvisorsData';



export default class LegalAdvisorData extends LightningElement {

    @wire(getLegalAdvisorsData) LAdvisor;
    LAdvisor({ error, data }) {
    if (data) {
        console.log('Legal Advisors Data:', data);
    } else if (error) {
        console.error('Error loading data:', error);
    }
}

}