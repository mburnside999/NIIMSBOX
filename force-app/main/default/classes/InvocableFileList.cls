global with sharing class InvocableFileList{
	
/**
 * @description invocable method to return all current attachments for an Application
 */
	@InvocableMethod(label = 
	'NIIM Invocable File List 'description = 
	'Invocable File List ')
	public static List<List<contentversion>> doAction(Request[] requests){
		// Process requests
		Map<Id, contentversion> parents = new Map<Id, contentversion>();

		String applicationId = requests[0].recordId;
		List<contentversion> listcv = new List<contentversion>();
		List<List<contentversion>> listlistcv = new List<List<contentversion>>();
		for (ContentDocumentLink cdl : [SELECT ContentDocumentId, LinkedEntityId, LinkedEntity.Name, LinkedEntity.Type, ShareType, Visibility
		                                FROM ContentDocumentLink
		                                WHERE LinkedEntityId IN (SELECT Id
		                                                         FROM Application__C
		                                                         WHERE id = :applicationId) AND LinkedEntity.Type = 'Application__c']){
			ContentVersion cv = [SELECT id, title, filetype, contentsize
			                     FROM contentversion
			                     WHERE contentdocumentid = :cdl.ContentDocumentId AND IsLatest = TRUE
			                     LIMIT 1];

			listcv.add(cv);
		}
		//prepare a List of Lists
		listlistcv.add(listcv);


		return listlistcv;
	}

	public with sharing class Request{
		@InvocableVariable(label = 
		'Record ID'required = true)
		public Id recordId;
		@InvocableVariable(label = 
		'Object API Name'required = false)
		public String objectName;
		@InvocableVariable(label = 
		'Parent ID'required = false)
		public Id parentId;

	}
}