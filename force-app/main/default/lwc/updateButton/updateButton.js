import { LightningElement } from 'lwc';
import updateData from '@salesforce/apex/ucl_UpdateData.updateData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class updateButton extends LightningElement {

    
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
          title: title,
          message: message,
          variant: variant
        });
        this.dispatchEvent(event);
      }
    
    
    
    handleClick(){
        updateData()
            .then(result => {

                this.showToast('Success when updating data', result, 'success');
            })
            .catch(error => {
                this.client = error;
                alert('Lo hizo Mal' + error);
                console.log(error)
            });
        
        
    }
  
}
