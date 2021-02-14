@isTest
private class ApplicationControllerTest {
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
    Test.startTest();
    List<Application__c> listapps = ApplicationController.getApplicationList();
    System.assert(listapps.size() >= 1);

    listapps = ApplicationController.findApplications('Application');
    System.assert(listapps.size() >= 1);

    Application__c app = ApplicationController.getSingleApplication();
    System.assert(app != null);
    Test.stopTest();
  }
}
