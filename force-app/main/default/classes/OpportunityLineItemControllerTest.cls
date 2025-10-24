// author: BEDOHAVE DEV – Oct 2025
// api: 64.0
@IsTest
private class OpportunityLineItemControllerTest {

    @IsTest
    static void testGetAndDelete() {
        // --- Données de test ---
        Id pricebookId = Test.getStandardPricebookId();

        Account acc = new Account(Name = 'Test Account');
        insert acc;

        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            AccountId = acc.Id
        );
        insert opp;

        // ⚠️ Pas de QuantityInStock__c ici
        Product2 prod = new Product2(
            Name = 'Test Product',
            IsActive = true
        );
        insert prod;

        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = pricebookId,
            Product2Id   = prod.Id,
            UnitPrice    = 100,
            IsActive     = true
        );
        insert pbe;

        OpportunityLineItem oli = new OpportunityLineItem(
            OpportunityId    = opp.Id,
            Quantity         = 2,
            UnitPrice        = 100,
            TotalPrice       = 200,
            PricebookEntryId = pbe.Id
        );
        insert oli;

        // --- Exécution des tests ---
        Test.startTest();
        List<OpportunityLineItem> items = OpportunityLineItemController.getOpportunityLineItems(opp.Id);
        System.assertEquals(1, items.size(), 'Une seule ligne d’opportunité doit être renvoyée');

        OpportunityLineItemController.deleteOpportunityLineItem(oli.Id);
        Test.stopTest();

        // --- Vérifications ---
        Integer remaining = [SELECT COUNT() FROM OpportunityLineItem WHERE OpportunityId = :opp.Id];
        System.assertEquals(0, remaining, 'La ligne doit être supprimée');
    }
}
