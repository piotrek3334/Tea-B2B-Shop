import { LightningElement, wire} from 'lwc';
import productsToCompare from '@salesforce/apex/PartitionCacheController.searchProductsToCompare';
import cleanProductsCompare from '@salesforce/apex/PartitionCacheController.cleanData';
import communityId from '@salesforce/community/Id';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ComparatorPage extends LightningElement {

    @wire(productsToCompare, {
            communityId: communityId,
            effectiveAccountId: '$resolvedEffectiveAccountId'
          })displayData;
    

      handleCleanClick(){
        cleanProductsCompare();
        
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Your comparator has been updated.',
                variant: 'success',
            })
        );
        this.updateRecordView();
      }
      
      updateRecordView() {
        setTimeout(() => {
             eval("$A.get('e.force:refreshView').fire();");
        },3000); 
        console.log('Refresh');
     }
      get resolvedEffectiveAccountId() {
        const effectiveAcocuntId = this.effectiveAccountId || '';
        let resolved = null;

        if (
            effectiveAcocuntId.length > 0 &&
            effectiveAcocuntId !== '000000000000000'
        ) {
            resolved = effectiveAcocuntId;
        }
        return resolved;
    }

    get hasResults(){
        return true;
    }
}

