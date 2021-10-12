import { LightningElement, track, api, wire } from 'lwc';
import getContactList from '@salesforce/apex/RecordController.getContactList'; 

// row actions
const actions = [
    { label: 'Record Details', name: 'record_details'}, 
    { label: 'Edit', name: 'edit'}, 
    { label: 'Delete', name: 'delete'}
];

const columns = [
    { label: 'Contact Name', fieldName: 'Name' },
    { label: 'Title', fieldName: 'Title'},
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
    { label: 'Email', fieldName: 'email' },
		{
        type: 'action',
        typeAttributes: {
            rowActions: actions,
            menuAlignment: 'right'
        }
    }
];

export default class SampleLWC1 extends LightningElement {
		data = [];
    columns = columns;
		@track record = [];
    @track bShowModal = false;
    @track currentRecordId;
    @track isEditForm = false;


    // eslint-disable-next-line @lwc/lwc/no-async-await
     connectedCallback() {
        getContactList()
            .then(result => {
                this.data = result;
            })
            .catch(error => {
                this.error = error;
            });
    }
		
		 handleRowActions(event){
        let actionName = event.detail.action.name;
        window.console.log('actionName ====> ' + actionName);
        let row = event.detail.row;

        window.console.log('row ====> ' + row);
        // eslint-disable-next-line default-case
        switch (actionName) {
            case 'record_details':
                this.viewCurrentRecord(row);
                break;
            case 'edit':
               // this.editCurrentRecord(row);
                break;
            case 'delete':
               // this.deleteCons(row);
                break;
        }
    }
		// view the current record details
    viewCurrentRecord(currentRow) {
        this.bShowModal = true;
        this.isEditForm = false;
        this.record = currentRow;
    }
		// closing modal box
    closeModal() {
        this.bShowModal = false;
    }
}