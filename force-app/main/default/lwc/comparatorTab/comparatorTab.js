import { LightningElement, api } from 'lwc';
import { resolve } from 'c/cmsResourceResolver';

export default class ComparatorTab extends LightningElement {

    @api product;

    get displayableProduct() {

        console.log('Price ' + this.product.prices);

        return {
            description: this.product.fields.Description,
            image: {
                alternativeText: this.product.defaultImage.alternativeText,
                url: resolve(this.product.defaultImage.url)
            },
            name: this.product.fields.Name,
            price: this.product.prices.unitPrice,
            sku: this.product.sku
        };
    }
}