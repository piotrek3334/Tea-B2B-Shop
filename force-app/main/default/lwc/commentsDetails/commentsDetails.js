import { LightningElement, wire, api, track } from 'lwc';
import getComments from "@salesforce/apex/CommentsController.getComments";
import { refreshApex } from '@salesforce/apex';
import { NavigationMixin } from 'lightning/navigation';
import isGuest from '@salesforce/user/isGuest';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {getRecordNotifyChange} from 'lightning/uiRecordApi';

export default class CommentsDetails extends NavigationMixin(LightningElement) {
    @api recordId;
    comments;

    @wire(getComments, { productId: "$recordId" }) comments;

    handleClick() {
          this.dispatchEvent(
              new ShowToastEvent({
                  title: 'Success',
                  message: 'Comments added',
                  variant: 'success'
              })
          );
      refreshApex(this.comments);
    }
    
    isGuestUser = isGuest;

    get hasResults() {
      return this.comments.data.length > 0;
      }

    navigateToListView() {
        // Navigate to the Contact object's Recent list view.
      this[NavigationMixin.Navigate]({
          type: 'standard__objectPage',
          attributes: {
          objectApiName: 'Product_Review__c',
          actionName: 'list'
          },
          state: {
              filterName: 'Default',
              recordId: this.recordId
          }
        });
    }
}