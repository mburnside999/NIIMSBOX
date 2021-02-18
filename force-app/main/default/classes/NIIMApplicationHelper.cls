global class NIIMApplicationHelper{
	/**
	 * Send out the startup object attachments to the specified email 
	 * @param {String} applicationId The Id of the Application__c
	 * @param {String} emailAddress The email address of the recipient
	 */
	global static void sendApplicationSummary(String applicationId, String emailAddress){
		Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
		// Set the recipient address
		message.setToAddresses(new List<String>{emailAddress});
		//Dosage__c,
		//Dosage_Form__c,
		String htmlstr = '<H2>Thankyou for your application.</H2><h3>Below is a summary of the information we received, including the attachments you provided.</h3>';
		htmlstr+='<h3>Please also find attached a declaration that you will need to sign and upload.</h3>';
		
		htmlstr += '<p>You can upload your declaration to our secure portal at the following link</p>';

		//htmlstr+='<p>https://niimportal.force.com/NIIMApplication/s/flowappdeclaration?varApplicationId='+applicationId+'</p>';
		//htmlstr+='<p>https://preprod-niimportal.cs114.force.com/NIIMApplication/s/flowappdeclaration?varApplicationId='+applicationId+'</p>';
		htmlstr+='<p>https://mbdevp1-niimportal.cs58.force.com/NIIMApplication/s/flowappdeclaration?varApplicationId='+applicationId+'</p>';



		htmlstr += '<p>You can update your application on our secure portal at the following link</p>';

		
		//htmlstr+='<p>https://niimportal.force.com/NIIMApplication/s/flowapplicationupdate?varApplicationId='+applicationId+'</p>';
		//htmlstr+='<p>https://preprod-niimportal.cs114.force.com/NIIMApplication/s/flowapplicationupdate?varApplicationId='+applicationId+'</p>';
		htmlstr+='<p>https://mbdevp1-niimportal.cs58.force.com/NIIMApplication/s/flowapplicationupdate?varApplicationId='+applicationId+'</p>';


		List<Application__c> applications = [SELECT id, name, Medicare_Provider_Number__c, address__c, ABN__c, email__c, Phone_Number__c, Practitioner_s_Name__c, Sites__c, Applied_To_Other_HREC_In_Past_12_Months__c, Commercial_Interest__c, AHPRA_Number__c, Professional_Association_Membership__c, risk_management_strategy__c, status__c, Qualifications_and_Expertise__c,
     (SELECT id, name, App_Good_Indications__c, 
     App_Good_Indications_Description__c, 
     Approved_Good_Alternative__c, Approved_In_Other_Jurisdiction__c, Clinical_Justification__c, Dosage__c, Dosage_Form__c, Dosage_Range__c, Expected_Duration_Of_Treatment__c, Justification_Not_Using_Alternative__c, Product_Trade_Name__c, Product_Company__c, Sponsor__c, Seriousness__c, Tried_Will_Try_Approved_Alternative__c, 
     Active_Ingredients_Concentrations__c FROM App_Goods__r),(select document__c,change_required__c from Concerns__r where status__c='Open')
		 FROM Application__c
		 WHERE id = :applicationId];
		 
		for (Application__c a : applications){
			htmlstr += '<p>============================================</p>';
			htmlstr += '<h2>Changes to your Application Required by NIIM</h2> ';


			if (a.concerns__r.size() > 0) {
				htmlstr+='<p>Please note that to progress your application NIIM requests you make the following changes:</p>';

	for( Changes_Required__c cr: a.concerns__r) {
	
		htmlstr+='<p><b>Document:</b> '+cr.document__c+'</p>';
		htmlstr+='<p><b>Change Required:</b> '+cr.change_required__c+'</p>';
		htmlstr+='<br/>';
	} 
} else {
		htmlstr+='<p><b>There are currently no changes required to your application</p>';


	}
	
			
			
			htmlstr += '<p>============================================</p>';

			htmlstr += '<h2>Practitioner Details</h2>';
			htmlstr += '<p><b>Reference:</b> ' + a.name + '</p>';
			htmlstr += '<p><b>Name:</b> ' + a.Practitioner_s_Name__c + '</p>';
			htmlstr += '<p><b>Address:</b> ' + a.address__c + '</p>';
			htmlstr += '<p><b>Email:</b> ' + a.email__c + '</p>';
			htmlstr += '<p><b>Phone:</b> ' + a.Phone_Number__c + '</p>';
			htmlstr += '<p><b>Medicare Provider No:</b> ' + a.Medicare_Provider_Number__c + '</p>';
			htmlstr += '<p><b>ABN:</b> ' + a.ABN__c + '</p>';
			htmlstr += '<p><b>AHPRA:</b> ' + a.AHPRA_Number__c + '</p>';
			htmlstr += '<p><b>Professional Assoc:</b> ' + a.Professional_Association_Membership__c + '</p>';
			htmlstr += '<p><b>Sites:</b> ' + a.Sites__c + '</p>';
			htmlstr += '<p><b>Has Applied to Other HREC:</b> ' + a.Applied_To_Other_HREC_In_Past_12_Months__c + '</p>';
			htmlstr += '<p><b>Commercial Interests:</b> ' + a.Commercial_Interest__c + '</p>';
			htmlstr += '<p><b>Qualifications and Experience:</b> ' + a.Qualifications_and_Expertise__c + '</p>';

			htmlstr += 
		'<p><b>Risk Management Strategy:</b> ' + a.Risk_Management_Strategy__c + 
		'</p>';
			htmlstr += '<p>============================================</p>';




			htmlstr += '<h2>Unapproved Goods</h2> ';

			for (App_Good__c appgood : a.App_Goods__r){
				htmlstr += '<h3>---- Product Information ------</h3>';

				htmlstr += '<p><b>Good:</b> ' + appgood.name + '</p>';
				htmlstr += '<p><b>Trade Name:</b> ' + appgood.Product_Trade_Name__c + '</p>';
				htmlstr += '<p><b>Company:</b> ' + appgood.Product_Company__c + '</p>';
				htmlstr += '<p><b>Active Ingredients Conc:</b> ' + appgood.Active_Ingredients_Concentrations__c + '</p>';
				htmlstr += '<p><b>Dosage Form:</b> ' + appgood.Dosage_Form__c + '</p>';
				htmlstr += '<p><b>Dosage:</b> ' + appgood.Dosage__c + '</p>';
				htmlstr += '<p><b>Sponsor:</b> ' + appgood.Sponsor__c + '</p>';
				htmlstr += '<p><b>Approved In  Other Jurisdictions:</b> ' + appgood.Approved_In_Other_Jurisdiction__c + '</p>';
				htmlstr += '<h3>---- Indications, Dosage and Justifications ------</h3>';

				htmlstr += '<p><b>Clinical Indications:</b> ' + appgood.App_Good_Indications__c + '</p>';
				htmlstr += '<p><b>Additional Indications Comments:</b> ' + appgood.App_Good_Indications_Description__c + '</p>';
				htmlstr += '<p><b>Seriousness:</b> ' + appgood.Seriousness__c + '</p>';

				htmlstr += '<p><b>Dosage Range:</b> ' + appgood.Dosage_Range__c + '</p>';
				htmlstr += '<p><b>Expected Duration:</b> ' + appgood.Expected_Duration_Of_Treatment__c + '</p>';
				htmlstr += '<p><b>Justification for using unapproved goods:</b> ' + appgood.Clinical_Justification__c + '</p>';
				htmlstr += '<p><b>Is there an approved product:</b> ' + appgood.Approved_Good_Alternative__c + '</p>';
				htmlstr += '<p><b>Have tried/will try the approved :</b> ' + appgood.Tried_Will_Try_Approved_Alternative__c + '</p>';
				htmlstr += '<p><b>Why is the approved good inappropriate :</b> ' + appgood.Justification_Not_Using_Alternative__c + '</p>';


				htmlstr += '<p>-----------------------------------------</p>';
			}
			htmlstr += '<p>============================================</p>';

		}

		List<String> contentids = new List<String>();
		for (ContentDocumentLink cdl : [SELECT ContentDocumentId, LinkedEntityId, LinkedEntity.Name, LinkedEntity.Type, ShareType, Visibility
		                                FROM ContentDocumentLink
		                                WHERE LinkedEntityId IN (SELECT Id
		                                                         FROM Application__C
		                                                         WHERE id = :applicationId) AND LinkedEntity.Type = 'Application__c']){
			Id cvid = [SELECT id, title, versiondata, filetype
			           FROM contentversion
			           WHERE contentdocumentid = :cdl.ContentDocumentId AND IsLatest = TRUE
			           LIMIT 1].Id;
			contentids.add(cvid);
		}
		message.setSubject('Application');
		message.setEntityAttachments(contentids);
		message.setHtmlBody(htmlstr);


		// Send the message
		try{
			Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{message});
		} catch (Exception e){
			throw e;
		}
	}
}