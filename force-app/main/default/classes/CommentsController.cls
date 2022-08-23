public with sharing class CommentsController {

    @AuraEnabled(cacheable=true scope='global')
    public static Product_Review__c[] getComments(String productId){
        return [
            SELECT Id, Review__c,  Product__r.Name
            FROM Product_Review__c WHERE Product__c =: productId
            ORDER BY CreatedDate DESC
            LIMIT 5
        ];
    }

    @AuraEnabled(cacheable=true scope='global')
    public static Product_Review__c[] getAllComments(String productId){
        return [
            SELECT Id, Review__c,  Product__r.Name
            FROM Product_Review__c WHERE Product__c =: productId
            ORDER BY CreatedDate DESC
        ];
    }
}