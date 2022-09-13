import { LightningElement, wire, api, track } from 'lwc';
import getComments from "@salesforce/apex/CommentsController.getComments";
import { refreshApex } from '@salesforce/apex';
import { NavigationMixin } from 'lightning/navigation';
import isGuest from '@salesforce/user/isGuest';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CommentsDetails extends NavigationMixin(LightningElement) {
    @api recordId;
    
    @wire(getComments, { productId: "$recordId" })comments;

    // wiredComments(result){
    //     this.wiredCommentsResult = result;
    //     if (result.data) {
    //         this.comments = result.data;
    //         this.error = undefined;
    //     } else if (result.error) {
    //         this.error = result.error;
    //         this.comments = undefined;
    //     }
    // };

    handleSuccess(event){
        const payload= event.detail;
        refreshApex(this.comments);
        const inputFields = this.template.querySelectorAll('.reset');
        if(inputFields){
            inputFields.forEach(element => {element.reset();        
            });
        }
    }

    handleClick() {
          this.dispatchEvent(
              new ShowToastEvent({
                  title: 'Success',
                  message: 'Comments added',
                  variant: 'success'
              })
          );
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