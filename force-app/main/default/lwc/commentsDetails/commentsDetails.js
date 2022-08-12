import { LightningElement, wire, api } from 'lwc';
import getComments from "@salesforce/apex/CommentsController.getComments";

export default class CommentsDetails extends LightningElement {
    @api recordId;
    textComments;

    @wire(getComments, { productId: "$recordId" }) comments;

    get hasResults() {
        return this.comments.data.length > 0;
      }


}