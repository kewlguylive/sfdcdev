public class TestDataFactory {

  
  public static CollaborationGroup ConstructCollaborationGroup(){
  /*
    CollaborationGroup cgroup = new CollaborationGroup();
    cgroup.Name = 'TEST' + Constants.INVENTORY_ANNOUNCEMENTS;
    cgroup.CanHaveGuests = false;
    cgroup.CollaborationType = 'Public';
    cgroup.IsArchived = false;
    cgroup.IsAutoArchiveDisabled = false;
    return cgroup;
    */
    
     CollaborationGroup chatterGroup = new CollaborationGroup(
            Name = 'TESTT'+Constants.INVENTORY_ANNOUNCEMENTS,  
            CollaborationType = 'Public'
        );
        return chatterGroup;
  }

  /**
   * @name CreateProducts
   * @description constructs a List of Product2 records for unit tests
   **/
  public static List<Product2> constructProducts(Integer cnt){
   /*
    List<Schema.PickListEntry> familyValueList = Product2.Family.getDescribe().getPickListValues();
    Integer listSize = familyValueList.size();

    List<Product2> productList = new List<Product2>();
    for (Integer i = 0; i < cnt; i++) {
      Product2 p = new Product2();
      p.Name = 'Product ' + i;
      p.Family = familyValueList[Math.mod(i, listSize)].getValue();
      p.Initial_Inventory__c = 10;
      p.IsActive = true;
      productList.add(p);
    }
    return productList;
    */
    List<Product2> products = new List<Product2>();
        for(Integer i = 1; i<=cnt ; i++){
            Product2 prod = new Product2(Name='Product'+i, Initial_Inventory__c = 10, isActive=true, family= Constants.PRODUCT_FAMILY.get(math.mod(i,4)).getValue());
            products.add(prod);
        }
        
        return products;
  }

  /**
   * @name CreatePricebookEntries
   * @description constructs a List of PricebookEntry records for unit tests
   **/
  public static List<PricebookEntry> constructPricebookEntries(List<Product2> productList){
    List<PricebookEntry> pbes = new List<PricebookEntry>();
    for (Product2 product: productList) {
      PricebookEntry pbe = new PricebookEntry();
      pbe.Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID;
      pbe.Product2Id = product.Id;
      pbe.IsActive = true;
      pbe.UnitPrice = 10;
      pbes.add(pbe);
    }
    return pbes;
  }

  /**
   * @name CreateAccounts
   * @description constructs a List of Account records for unit tests
   **/
  public static List<Account> constructAccounts(Integer cnt){
    List<Account> accts = new List<Account>();
    for (Integer i = 0; i < cnt; i++) {
      Account acct = new Account();
      acct.Name = 'Account ' + i;
      accts.add(acct);
    }
    return accts;
  }

  /**
   * @name CreateContacts
   * @description constructs a List of Contacxt records for unit tests
   **/
  public static List<Contact> constructContacts(Integer cnt, List<Account> accts){
    Integer listSize = accts.size();

    List<Contact> contactList = new List<Contact>();
    for (Integer i = 0; i < cnt; i++) {
      Contact c = new Contact();
      c.LastName = 'Contact ' + i;
      c.AccountId = accts[Math.mod(i, listSize)].Id;
      contactList.add(c);
    }

    return contactList;
  }

  /**
   * @name CreateOrders
   * @description constructs a List of Order records for unit tests
   **/
  public static List<Order> constructOrders(Integer cnt, List<Account> accts){
    Integer listSize = accts.size();

    List<Order> orders = new List<Order>();

    for (Integer i = 0; i < cnt; i++) {
      Order o = new Order();
      o.Name = 'Order ' + i;
      o.AccountId = accts[Math.mod(i, listSize)].Id;
      o.EffectiveDate = Date.today();
      o.Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID;
      o.Status = 'Draft';
      orders.add(o);
    }

    return orders;
  }

  /**
   * @name CreateOrderItems
   * @description constructs a List of OrderItem records for unit tests
   **/
  public static List<OrderItem> constructOrderItems(Integer cnt, List<Pricebookentry> pbes, List<Order> ords){
    Integer pbeListSize = pbes.size();
    Integer orderListSize = ords.size();

    List<OrderItem> orderItemList = new List<OrderItem>();

    for (Integer i = 0; i < cnt; i++) {
      OrderItem oi = new OrderItem();
      oi.OrderId = ords[Math.mod(i, orderListSize)].Id;
      oi.PriceBookEntryId = pbes[Math.mod(i, pbeListSize)].Id;
      oi.Quantity = Constants.DEFAULT_ROWS;
      oi.UnitPrice = 100;
      orderItemList.add(oi);
    }

    return orderItemList;
  }

  public static void VerifyQuantityOrdered(Product2 originalProduct, Product2 updatedProduct, Integer qtyOrdered){
    Integer sumQuantity = Integer.valueOf(originalProduct.Quantity_Ordered__c) + qtyOrdered;
    System.assertEquals(updatedProduct.Quantity_Ordered__c , sumQuantity);
    //System.Assert((updatedProduct.Quantity_Ordered__c - originalProduct.Quantity_Ordered__c) == 0);
  }

  public static void InsertTestData(Integer cnt){
   /*
    insert constructCollaborationGroup();

    List<Product2> productList = constructProducts(cnt);
    insert productList;

    List<PricebookEntry> pbes = constructPricebookEntries(productList);
    insert pbes;

    List<Account> accts = constructAccounts(cnt);
    insert accts;
    insert constructContacts(cnt, accts);

    List<Order> ords = constructOrders(cnt, accts);
    insert ords;

    insert constructOrderItems(cnt, pbes, ords);
    */
        CollaborationGroup groups = TestDataFactory.ConstructCollaborationGroup();
        insert groups;
        
        List<Product2>  products= TestDataFactory.ConstructProducts(cnt);
        insert products;
        
        List<PriceBookEntry> entries = TestDataFactory.ConstructPricebookEntries(products);
        insert entries;
        
        List<Account> accts = TestDataFactory.ConstructAccounts(cnt);
        insert accts;
        
        List<Contact> contacts = TestDataFactory.ConstructContacts(cnt,accts);
        insert contacts;
        
        List<Order> orders = TestDataFactory.ConstructOrders( cnt,  accts);
        insert orders;
        
        List<OrderItem> items = TestDataFactory.ConstructOrderItems(cnt, entries, orders);
        insert items;
  }
}