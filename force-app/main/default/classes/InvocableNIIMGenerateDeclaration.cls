global with sharing class InvocableNIIMGenerateDeclaration{
	
/**
 * @description invocable method to generate an Application declaration
 * 
 * Generation is performed using VisualForce page NIIMGenerateDeclarationVFPage
 * 
 */
	
	@InvocableMethod(label = 
	'NIIM Invocable Declaration Generator'description = 
	'NIIM invocable declaration generator')
	public static List<String> generate(List<Requests> requests){
		// initialise our list of results

		List<String> result = new List<String>();

		String str = '';

		String email = requests[0].email;
		String applicationId = requests[0].applicationId;

		// DEPRECATED - we dont send via this class
		//NIIMApplicationHelper.sendApplicationSummary(applicationId, email);

		PageReference page = new PageReference('/apex/NIIMGenerateDeclarationVFPage');

		page.getParameters().put('Id', applicationId);
		// generate and PDF blob
		// You can save this blob as a file, document, or attachment!

		blob contentBlob;
		if (Test.isRunningTest()){
			contentBlob = blob.valueOf('Unit.Test');
		} else{
			contentBlob = page.getContentAsPDF();
		}


		ContentVersion cv = new ContentVersion();
		cv.VersionData = contentBlob;
		cv.Title = 'declaration.pdf';
		cv.PathOnClient = 'declaration.pdf';
		insert cv;
		cv = [SELECT Id, ContentDocumentId
		      FROM ContentVersion
		      WHERE Id = :cv.Id
		      LIMIT 1];

		ContentDocumentLink cdl = new ContentDocumentLink();
		cdl.ContentDocumentId = cv.ContentDocumentId;
		cdl.ShareType = 'I';
		cdl.LinkedEntityId = applicationId;
		insert cdl;


		str = 'Completed';
		result.add(str);
		return (result); //return our list of results
	}

	global class Requests{
		@InvocableVariable
		global Id applicationId;
		@InvocableVariable
		global String email;

	}
}