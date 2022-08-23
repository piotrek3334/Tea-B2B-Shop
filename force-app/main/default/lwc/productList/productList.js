import { LightningElement, wire, api } from 'lwc';
import getAllProducts from '@salesforce/apex/B2BGetInfo.getAllProducts';
import communityId from '@salesforce/community/Id';
import getCartSummary from '@salesforce/apex/B2BGetInfo.getCartSummary';

export default class ProductList extends NavigationMixin(LightningElement) {
    /**
     * Gets the effective account - if any - of the user viewing the product.
     *
     * @type {string}
     */
     @api
     get effectiveAccountId() {
         return this._effectiveAccountId;
     }

         /**
     * Gets or sets the unique identifier of a product.
     *
     * @type {string}
     */
    @api
    recordId;

    /**
     * Gets or sets the custom fields to display on the product
     * in a comma-separated list of field names
     *
     * @type {string}
     */
    @api
    customDisplayFields;

         /**
     * Sets the effective account - if any - of the user viewing the product
     * and fetches updated cart information
     */
    set effectiveAccountId(newId) {
        this._effectiveAccountId = newId;
        this.updateCartInformation();
    }

        /**
     * Gets the normalized effective account of the user.
     *
     * @type {string}
     * @readonly
     * @private
     */
         get resolvedEffectiveAccountId() {
            const effectiveAccountId = this.effectiveAccountId || '';
            let resolved = null;
    
            if (
                effectiveAccountId.length > 0 &&
                effectiveAccountId !== '000000000000000'
            ) {
                resolved = effectiveAccountId;
            }
            return resolved;
        }

        /**
     * The full product information retrieved.
     *
     * @type {ConnectApi.ProductOverviewCollection}
     * @private
     */
         @wire(getAllProducts, {
            communityId: communityId,
            effectiveAccountId: '$resolvedEffectiveAccountId'
        })
        productsList;

    /**
     * A normalized collection of items suitable for display.
     *
     * @private
     */
     _items = [];

        get displayableProducts() {
            
            }

        updateCartInformation() {
            getCartSummary({
                communityId: communityId,
                effectiveAccountId: this.resolvedEffectiveAccountId
            })
                .then((result) => {
                    this.cartSummary = result;
                })
                .catch((e) => {
                    // Handle cart summary error properly
                    // For this sample, we can just log the error
                    console.log(e);
                });
        }
}