public with sharing class ProductController {

    // public static void getProductPriceDetail(){
    //     List<String> price = new List<String>();
    //     String webstoreId; 
    //     String productId; 
    //     String effectiveAccountId;
    //   //  try {
    //         ConnectApi.ProductPrice priceList = ConnectApi.ProductPrice.getProductPrice('webstoreId', 'productId', 'effectiveAccountId');

    //         for (ConnectApi.ProductPrice priceInput : priceList) {
    //             price.add(priceInput.listPrice());
    //         }

    //  //   } catch (Exception e) {
    //    //     System.debug('Error in get product price :' + e.getMessage());
    //    // }
    // }

    // @AuraEnabled(cacheable=true)
    // public static void getProductDetail(){
    //     String webstoreId;
    //     String productId;
    //     String effectiveAccountId;
    //     List<String> fields;
    //     Boolean excludeFields;
    //     List<String> mediaGroups;
    //     Boolean excludeMedia;
    //     Boolean excludeEntitlementDetails;
    //     Boolean excludePrimaryProductCategory;

    //     try {
    //     ConnectApi.ProductDetail image = ConnectApi.ProductDetail.getProduct(webstoreId, 
    //     productId, effectiveAccountId, fields, excludeFields, mediaGroups, 
    //     excludeMedia, excludeEntitlementDetails, excludePrimaryProductCategory);
    //     } catch (Exception e) {
    //         System.debug('Error in get product price :' + e.getMessage());
    //     }
    // }
}
