import { LightningElement, wire, api } from 'lwc';
import getApplicationList from '@salesforce/apex/ApplicationController.getApplicationList';


const COLS = [
    { label: 'Application', fieldName: 'Name', editable: false },
    { label: 'Practitioner', fieldName: 'Practitioner_s_Name__c', editable: false },
    { label: 'Provider', fieldName: 'Medicare_Provider_Number__c', editable: false },
    { label: 'Address', fieldName: 'Address__c', editable: false },
    { label: 'Status', fieldName: 'Status__c', editable: false },
    { label: 'Created', fieldName: 'CreatedDate',type:'date',editable: false }

];
export default class Niimapplicationlist extends LightningElement {

columns=COLS;
    @wire(getApplicationList, { })
    application;




}