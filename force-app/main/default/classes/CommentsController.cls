public with sharing class CommentsController {

    @AuraEnabled(cacheable=true scope='global')
    public static Product_Review__c[] getComments(String productId){
        return [
            SELECT Id, Review__c,  Product__r.Name
            FROM Product_Review__c WHERE Product__c =: productId
            ORDER BY CreatedDate 
            LIMIT 5
        ];
    }

    @AuraEnabled(cacheable=true scope='global')
    public static void saveComments(String text, String productId){
        try {        
            Product_Review__c review = new Product_Review__c(Review__c = text,Product__c = productId);
            insert review;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
    }
}
