@isTest
private class NIIMApplicationHelperTest {
  @isTest
  static void myTest() {
    Application__c a = new Application__c(
      email__c = 'burnside.mike@gmail.com',
      Practitioner_s_name__c = 'xx',
      AHPRA_Number__c = 'MED0000000000'
    );
    insert a;
    App_Good__c ag = new App_Good__c(
      Product_Trade_Name__c = 'XXX',
      Application__c = a.Id
    );
    insert ag;
    Indication__c i = new Indication__c(
      indication__c = 'xx',
      Application__c = a.Id
    );
    insert i;

//test for handling of an invalid email
    try {
      NIIMApplicationHelper.sendApplicationSummary( a.Id,'1111');
    } catch (Exception e) {   
      System.debug(e.getMessage());
      System.assert(e.getMessage() != null);
    }


  }
}