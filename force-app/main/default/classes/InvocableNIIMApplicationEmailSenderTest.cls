@isTest
public with sharing class InvocableNIIMApplicationEmailSenderTest {
  @isTest
  static void myInvocableTest() {
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
    

   git 

    // InvocableNIIMApplicationEmailSender.Requests r = new InvocableNIIMApplicationEmailSender.Requests();
    // r.email='burnside.mike@gmail.com';
    // r.applicationId=a.id;
    // req.add(r);
    // List<String> s = InvocableNIIMApplicationEmailSender.send(req);
    // //s=InvocableNIIMApplicationEmailSender.send(req);
  }
}