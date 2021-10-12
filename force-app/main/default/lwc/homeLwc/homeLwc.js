import { LightningElement, wire, api, track } from 'lwc';
import getHealthApps from '@salesforce/apex/HealthAppsController.getHealthApps';
import savehealthApp from '@salesforce/apex/HealthAppsController.savehealthApp';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import NAME_FIELD from '@salesforce/schema/HealthApplication__c.Name';
import OPTIONNAME_FIELD from '@salesforce/schema/HealthApplication__c.Option__c';
import ID_FIELD from '@salesforce/schema/HealthApplication__c.Id';
import ORGANIZATION_TYPE_FIELD from '@salesforce/schema/HealthApplication__c.Organization_Type__c';
import ACTION_FIELD from '@salesforce/schema/HealthApplication__c.Action__c';

const COLS = [
    { label: 'Name', fieldName: 'Name', editable: true },
    { label: 'Option', fieldName: 'option__C', editable: true },
    { label: 'Account Name', fieldName: 'Account_Name__r.Name' },
    { label: 'Applicant Name', fieldName: 'Applicant__r.Name' }
];

export default class HomeLwc extends LightningElement {

    columns = COLS;
    draftValues = [];

    @track isModalOpen = false;
    openModal() {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
    }
    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
       
    }

    @track optionname = OPTIONNAME_FIELD;
    @track actionname = ACTION_FIELD;
    @track orgtype = ORGANIZATION_TYPE_FIELD;
    rec = {
        Option__c : this.optionname,
        Action__c : this.actionname,
        Organization_Type__c : this.orgtype
    }

    @wire(getHealthApps, { option: 'Global' })
    healthapps;

    handleOrgTypeChange(event) {
        this.rec.Organization_Type__c = event.target.value;
    }
    
    handleActionChange(event) {
        this.rec.Action__c = event.target.value;      
    }
    handleRowAction(event){
        const actionName = event.detail.action.name;
        const row = event.detail.row;

    }
    
    handleOptionChange(event) {
        this.rec.Option__c = event.target.value;     
    }

    handleClick() {
        this.isModalOpen = false;
        savehealthApp({ app : this.rec })
            .then(result => {
                this.message = result;
                this.error = undefined;
                if(this.message !== undefined) {
                    this.rec.Organization_Type__c = '';
                    this.rec.Action__c = '';
                    this.rec.Option__c = '';
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Health Application created',
                            variant: 'success',
                        }),
                    );
                }
                
                console.log(JSON.stringify(result));
                console.log("result", this.message);
            })
            .catch(error => {
                this.message = undefined;
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
                console.log("error", JSON.stringify(this.error));
            });
    }

    handleSave(event) {

        const fields = {}; 
        fields[ID_FIELD.fieldApiName] = event.detail.draftValues[0].Id;
        fields[NAME_FIELD.fieldApiName] = event.detail.draftValues[0].FirstName;
        fields[OPTIONNAME_FIELD.fieldApiName] = event.detail.draftValues[0].LastName;

        const recordInput = {fields};

        updateRecord(recordInput)
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Health App updated',
                    variant: 'success'
                })
            );
            // Display fresh data in the datatable
            return refreshApex(this.healthapps).then(() => {

                // Clear all draft values in the datatable
                this.draftValues = [];

            });
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating or reloading record',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });
    }


}