@isTest
public class testAdvancedApexSpecialist {
	@isTest(seeAllData=true)
    public static void startTesting(){
        Product2 testProduct = new Product2();
        testProduct.isActive = true;
        testProduct.Name = 'Test';
        testProduct.Family = 'Entree';
        testProduct.Initial_Inventory__c = 20;
        testProduct.Quantity_Ordered__c = 0;
        insert testProduct;
        
        PricebookEntry testPricebookEntry = new PricebookEntry();
        testPricebookEntry.Product2Id = testProduct.Id;
        testPricebookEntry.Pricebook2Id = [SELECT Id 
                                           from Pricebook2 
                                           WHERE isStandard = TRUE LIMIT 1].Id;
        testPricebookEntry.UnitPrice = 15;
        testPricebookEntry.UseStandardPrice = false;
        testPricebookEntry.isActive = true;
        insert testPricebookEntry;
        
        List<Account> testAccounts = [SELECT Id FROM Account LIMIT 1];
        
        Order testOrder = new Order();
        testOrder.AccountId = testAccounts[0].Id;
        testOrder.EffectiveDate = system.today();
        testOrder.Status = 'Draft';
        testOrder.Pricebook2Id = testPricebookEntry.Pricebook2Id;
        insert testOrder;
        
        OrderItem testOrderItem = new OrderItem();
        testOrderItem.OrderId = testOrder.Id;
        testOrderItem.PricebookEntryId = testPricebookEntry.Id;
        testOrderItem.Quantity = 1;
        testOrderItem.UnitPrice = 1;
        insert testOrderItem;
        
        testProduct = [SELECT Quantity_Ordered__c 
                       FROM Product2 
                       WHERE Id = :testProduct.Id LIMIT 1];
        system.assert( testProduct.Quantity_Ordered__c == 0, 
                      'Dont forget to take into account whether the Order is Activated');
        
        testOrder.Status = constants.ACTIVATED_ORDER_STATUS;
        update testOrder;
        testOrder = [SELECT Id, Status, ActivatedDate FROM Order WHERE ID =:testOrder.Id LIMIT 1];
        system.assert( testOrder.ActivatedDate != null );
        system.assert( testOrder.Status == constants.ACTIVATED_ORDER_STATUS );
        
        testProduct = [SELECT Quantity_Ordered__c FROM Product2 WHERE Id = :testProduct.Id LIMIT 1];
        system.assert( testProduct.Quantity_Ordered__c == testOrderItem.Quantity, 
                      'Quantity Ordered was not updated');
        /// second block of tests
        system.assert( [SELECT Id FROM Product2].size() >= 12 );
        orderExtension ext = new orderExtension(new apexPages.standardController(new Order()));
        
        Set<String> optionLabels = new Set<String>();
        optionLabels.add(constants.SELECT_ONE);
        for ( Schema.PicklistEntry p : constants.PRODUCT_FAMILY ){
            optionLabels.add(p.getLabel());
        }
        
        List<SelectOption> userOptions = ext.getFamilyOptions();
        system.debug('Line 65 ' + userOptions);
        system.assert( userOptions[0].getLabel() == constants.SELECT_ONE );
        for ( Integer i=1;i<userOptions.size();i++ ){
          system.assert( userOptions[i].getLabel() == constants.PRODUCT_FAMILY[i-1].getLabel() );
        }
        
        system.assert( ext.gethasNext() == true );
        system.assert( ext.gethasPrevious() == false );
        system.assert( ext.gettotalPages() == 3 );
        system.assert( ext.getPageNumber() == 1 );
        
        ext.next();
        system.assert( ext.gethasNext() == true );
        system.assert( ext.gethasPrevious() == true );
        system.assert( ext.gettotalPages() == 3 );
        system.assert( ext.getPageNumber() == 2 );
        
        ext.last();
        system.assert( ext.gethasNext() == false );
        system.assert( ext.gethasPrevious() == true );
        system.assert( ext.gettotalPages() == 3 );
        system.assert( ext.getPageNumber() == 3 );
        
        ext.previous();
        system.assert( ext.gethasNext() == true );
        system.assert( ext.gethasPrevious() == true );
        system.assert( ext.gettotalPages() == 3 );
        system.assert( ext.getPageNumber() == 2 );
        
        ext.first();
        system.assert( ext.gethasNext() == true );
        system.assert( ext.gethasPrevious() == false );
        system.assert( ext.gettotalPages() == 3 );
        system.assert( ext.getPageNumber() == 1 );
    }
}