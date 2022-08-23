import { LightningElement, api, wire } from 'lwc';
import getComments from "@salesforce/apex/CommentsController.getAllComments";

export default class CommentsList extends LightningElement {
    @api recordId;
    comments
    @wire(getComments, { productId: "$recordId" }) comments;

    get hasResults() {
        return this.comments.data.length > 0;
      }
}