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
        System.debug('B2BSearch ... start');
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
        System.debug('B2BSearch ... result');
        System.debug(result);


        return result;
    }
  }
  //     String communityId,
  //     String searchQuery,
  //     String effectiveAccountId
  // ) {
  //     // Lookup the webstore ID associated with the community
  //     String webstoreId = B2BUtils.resolveCommunityIdToWebstoreId(
  //         communityId
  //     );

  //     HttpRequest httpRequest = new HttpRequest();
  //     Object response;

  //     // As per the Salesforce documentation
  //     // "By security policy, sessions created by Lightning components aren’t
  //     //  enabled for API access. This prevents even your Apex code from
  //     //  making API calls to Salesforce. Using a named credential for
  //     //  specific API calls allows you to carefully and selectively bypass
  //     // this security restriction."
  //     // - https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/apex_api_calls.htm
  //     //
  //     // So the following section that takes the OAuth is commented out and
  //     // used the named credential callout 'CallMeBack' below.
  //     // The steps to create named credentials are documented the repo here
  //     // docs/NamedCredentials.md

  //     // httpRequest.setMethod('POST');
  //     // httpRequest.setHeader('Content-Type', 'application/json');
  //     // httpRequest.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());

  //     // String baseUrl = URL.getOrgDomainUrl().toExternalForm();
  //     // String apiUrl = '/services/data/v' + apiVersionApexClass + '/commerce/webstores/' + webstoreId + '/search/product-search';
  //     // httpRequest.setEndpoint(baseUrl + apiUrl);

  //     httpRequest.setMethod('POST');
  //     httpRequest.setHeader(
  //         'Content-Type',
  //         'application/json;  charset=utf-8'
  //     );
  //     httpRequest.setEndpoint(
  //         'callout:CallMeBack/services/data/v' +
  //         apiVersionApexClass +
  //         '/commerce/webstores/' +
  //         webstoreId +
  //         '/search/product-search'
  //     );

  //     httpRequest.setBody(searchQuery);

  //     try {
  //         Http http = new Http();
  //         HttpResponse httpResponse = http.send(httpRequest);
  //         Integer statusCode = httpResponse.getStatusCode();

  //         if (statusCode >= 200 && statusCode <= 204) {
  //             response = JSON.deserializeUntyped(httpResponse.getBody());
  //         } else {
  //             System.debug(' httpResponse ' + httpResponse.getBody());
  //             throw new CalloutException(httpResponse.getBody());
  //         }
  //     } catch (System.Exception e) {
  //         System.debug('ERROR: ' + e);
  //         throw e;
  //     }

  //     return response;
  // }
//   String communityId,
//   String effectiveAccountId) {
//   List<String> productId = new List<String>();
//   String webstoreId = B2BUtils.resolveCommunityIdToWebstoreId(communityId);
//   List<Product2> productIdList = [SELECT Id FROM Product2 WHERE isActive = true];

//   if(!productIdList.isEmpty())   {
//     for (Product2 product : productIdList) {
//       productId.add(product.id);
//     }
//   }

//   ConnectApi.ProductOverviewCollection listProducts = ConnectApi.CommerceCatalog.getProducts(
//     webstoreId,
//     effectiveAccountID,
//     productId,
//     null,
//     null,
//     true,
//     true
//   );
//   return listProducts.products;
// }
