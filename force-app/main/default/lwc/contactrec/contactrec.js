import { LightningElement, api ,track} from 'lwc';

export default class Contactrec extends LightningElement {
 @api recordId;
 @api objectApiName;
 @track currentObjectName;
 @track currentRecordId;
 fields = ['AccountId','Email','Title','Phone','Name'];

 connectedCallback(){
     this.currentRecordId = this.recordId;
     this.currentObjectName = this.objectApiName;
 }

}