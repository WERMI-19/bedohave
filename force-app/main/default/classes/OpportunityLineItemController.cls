// author: BEDOHAVE DEV – Oct 2025
// api: 64.0
public with sharing class OpportunityLineItemController {

    @AuraEnabled(cacheable=true)
    public static List<OpportunityLineItem> getOpportunityLineItems(Id opportunityId) {
        if (opportunityId == null) return new List<OpportunityLineItem>();

        // ⚠️ IMPORTANT : pas de champ QuantityInStock__c ici
        List<OpportunityLineItem> rawItems = [
            SELECT Id,
                   Quantity,
                   UnitPrice,
                   Product2.Id,
                   Product2.Name
            FROM OpportunityLineItem
            WHERE OpportunityId = :opportunityId
            ORDER BY CreatedDate ASC
        ];
        return rawItems;
    }

    @AuraEnabled
    public static void deleteOpportunityLineItem(Id lineItemId) {
        if (lineItemId == null) {
            throw new AuraHandledException('Identifiant invalide.');
        }
        delete [SELECT Id FROM OpportunityLineItem WHERE Id = :lineItemId LIMIT 1];
    }
}

