import { LightningElement, wire } from 'lwc';
import UpsertAdvisors from '@salesforce/apex/ucl_UpsertAdvisors.UpsertAdvisors';
import UpsertClients from '@salesforce/apex/uclUpsertClients.UpsertClients';

export default class updateButton extends LightningElement {

    @wire (UpsertAdvisors)
    wiredUpsertAdvisors({error, data}){
        if(data){
            this.legalAdvisor = data;
            alert('Lo hizo Bien');
        }else if(error){
            this.legalAdvisor = error;
            alert('Lo hizo Mal' + error);
            console.log(error)
        }
    }
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
        UpsertAdvisors();
        UpsertClients();
        alert('El button funciona')
    }

}