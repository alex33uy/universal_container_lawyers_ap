import { LightningElement, wire } from 'lwc';
import UpsertClients from '@salesforce/apex/ucl_UpsertClients.UpsertClients';

export default class updateButton extends LightningElement {

    @wire (UpsertClients)
    wiredUpsertAdvisors({error, data}){
        if(data){
            this.client = data;
            alert('Lo hizo Bien');
        }else if(error){
            this.client = error;
            alert('Lo hizo Mal' + error);
            console.log(error)
        }
    }
    handleClick(){
        UpsertClients();
        alert('El button funciona')
    }

}