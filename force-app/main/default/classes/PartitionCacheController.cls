public with sharing class PartitionCacheController {
    @AuraEnabled(cacheable=true)
    public static void storeData(String product){
        List<String> listProductsToCompare = new List<String>();
        if (retrieveData() == null) {
            listProductsToCompare.add(product);
        } else {
        listProductsToCompare = retrieveData();
        listProductsToCompare.add(product);
        }

        try {
        Cache.Session.put('ProductsCompare', listProductsToCompare);
        } catch (Exception e) {
            throw e;
        }
    }

    @AuraEnabled(cacheable=true)
    public static void cleanData(){
        try {
            Cache.Session.put('ProductsCompare', new List<String>());
            } catch (Exception e) {
                throw e;
            }
    }

    @AuraEnabled(cacheable=true)
    public static List<String> retrieveData(){
      return (List<String>) Cache.Session.get('ProductsCompare');
    }

    @AuraEnabled(cacheable=true)
    public static List<ConnectApi.ProductOverview> searchProductsToCompare(
        String communityId,
        String effectiveAccountId){

        String webstoreId = B2BUtils.resolveCommunityIdToWebstoreId(communityId);
        List<String> ids = new List<String>();
        
        if (retrieveData() != null) {
            ids = retrieveData();
        }
        try{
            ConnectApi.ProductOverviewCollection result = ConnectApi.CommerceCatalog.getProducts(
                webstoreId, 
                effectiveAccountId, 
                ids, 
                null,
                null,
                false,
                false);
                return result.products;
        } catch (Exception e) {
            throw e;
        }
    }
}
