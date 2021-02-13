@isTest
private class InvocableFileListTest{
	@isTest
	static void myTest(){
		Application__c a = new Application__c(email__c = 'burnside.mike@gmail.com', Practitioner_s_name__c = 'xx', AHPRA_Number__c = 'MED0000000000');
		insert a;
		App_Good__c ag = new App_Good__c(Product_Trade_Name__c = 'XXX', Application__c = a.Id);
		insert ag;



		String myFileContent = 'Mikes File upload content';

		ContentVersion conVer = new ContentVersion();
		conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
		conVer.PathOnClient = 'test.txt'; // The files name, extension is very important here which will help the file in preview.
		conVer.Title = 'Test File'; // Display name of the files
		conVer.VersionData = EncodingUtil.base64Decode(myFileContent); // converting your binary string to Blog
		insert conVer;    //Insert ContentVersion

		Id conDoc = [SELECT ContentDocumentId
		             FROM ContentVersion
		             WHERE Id = :conVer.Id].ContentDocumentId;
		//create ContentDocumentLink  record
		ContentDocumentLink conDocLink = New ContentDocumentLink();
		conDocLink.LinkedEntityId = a.Id; // Specify RECORD ID here i.e Any Object ID (Standard Object/Custom Object)
		conDocLink.ContentDocumentId = conDoc;  //ContentDocumentId Id from ContentVersion
		conDocLink.shareType = 'V';
		insert conDocLink;

		Test.startTest();

		InvocableFileList.Request argument;
		argument = new InvocableFileList.Request();
		argument.recordId = a.id;

		List<String> teststr = new List<String>();
		List<List<contentversion>> result = new List<List<contentversion>>();

		result = InvocableFileList.doAction(new List<InvocableFileList.Request>{argument});

		Test.stopTest();
		System.assert(result.size() == 1);


		//System.assert(teststr[0] == 'Completed');
	}
}