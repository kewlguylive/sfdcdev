import { LightningElement, api, wire } from 'lwc';
import oppties from '@salesforce/apex/LwcOpportunityController.getOpportunities';

export default class OpportunityRecords extends LightningElement {
    @api recordId;
    lstOppties = [];

    @wire (oppties, {recordId: '$recordId'})
    fetchOppties({error, data}){
        if(data){
            console.log('OPPTIES'+data);
            this.lstOppties = data; 
        }else if(error){
            console.log(error);
        }
    };

}