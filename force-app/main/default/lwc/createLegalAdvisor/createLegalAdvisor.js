import { LightningElement } from 'lwc';

export default class CreateLegalAdvisor extends LightningElement {

    handleSave() {
        const recordForm = this.template.querySelector('lightning-record-edit-form');
        recordForm.submit();
    }


}