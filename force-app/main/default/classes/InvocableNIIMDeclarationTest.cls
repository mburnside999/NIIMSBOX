@IsTest
public with sharing class InvocableNIIMDeclarationTest{
	@isTest
	static void myInvocableTest(){
        //insert a test Application
        Application__c a = new Application__c(email__c = 'burnside.mike@gmail.com', Practitioner_s_name__c = 'xx', AHPRA_Number__c = 'MED0000000000');
		insert a;
		
        Test.StartTest();
		InvocableNIIMGenerateDeclaration.Requests argument;
		argument = new InvocableNIIMGenerateDeclaration.Requests();
		argument.email = 'burnside.mike@gmail.com';
		argument.applicationId = a.id;

		List<String> teststr = new List<String>();
		teststr = InvocableNIIMGenerateDeclaration.generate(new List<InvocableNIIMGenerateDeclaration.Requests>{argument});
		Test.stopTest();
		
		System.assert(teststr[0] == 'Completed');

		// InvocableNIIMApplicationEmailSender.Requests r = new InvocableNIIMApplicationEmailSender.Requests();
		// r.email='burnside.mike@gmail.com';
		// r.applicationId=a.id;
		// req.add(r);
		// List<String> s = InvocableNIIMApplicationEmailSender.send(req);
		// //s=InvocableNIIMApplicationEmailSender.send(req);
	}
}