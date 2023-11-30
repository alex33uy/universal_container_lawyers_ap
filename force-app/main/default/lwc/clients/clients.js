import { LightningElement, wire } from 'lwc';
import showClientData from '@salesforce/apex/ucl_QueryData.showClientData';

export default class Clients extends LightningElement {
    @wire(showClientData)
    wiredClients({ error, data }) {
        if (data) {
            this.clients = data;
    
        } else if (error) {
            this.error = error;
            console.log('este es el error '+error)
        }
    }
}