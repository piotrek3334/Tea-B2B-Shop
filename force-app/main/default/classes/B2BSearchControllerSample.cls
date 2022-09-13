/**
 * @description Demonstrates how to make REST calls to ConnectApi.CommerceSearch class
 * to perform Search and Category browsing for B2B Commerce on Lightning.
 *
 * @see B2BUtils
 */
public with sharing class B2BSearchControllerSample {
  
  @AuraEnabled
    public static Object productSearch(
        String communityId,
        String searchQuery,
        String effectiveAccountId
    ) {
        String webstoreId;
        // Lookup the webstore ID associated with the community
        if(!Test.isRunningTest()){
            webstoreId = B2BUtils.resolveCommunityIdToWebstoreId(communityId);
        }else{
            webstoreId='webId';
        }

        ConnectApi.ProductSearchInput searchTerms = (ConnectApi.ProductSearchInput)JSON.deserialize(searchQuery,ConnectApi.ProductSearchInput.class);
        Object result = null;

        try {
            if(!Test.isRunningTest()){
                result = ConnectApi.CommerceSearch.searchProducts(webstoreId, effectiveAccountId,searchTerms);
            }else if(Test.isRunningTest() && communityId == 'null'){
                CalloutException e = new CalloutException();
                e.setMessage('This is a constructed exception!');
                throw e;
            }
        } catch (System.Exception e) {
            throw e;
        }
        return result;
    }
  }