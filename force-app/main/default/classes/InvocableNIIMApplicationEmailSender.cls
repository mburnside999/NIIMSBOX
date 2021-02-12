global with sharing class InvocableNIIMApplicationEmailSender{
/**
 * @description invocable method to email an Application content pack to a specified email address
 * @see NIIMApplicationHelper
 */
	@InvocableMethod(label = 
	'NIIM Invocable Email Sender method'description = 
	'NIIM invocable to send an info pack by email')
	public static List<String> sender(List<Requests> requests){
		// initialise our list of results

		List<String> result = new List<String>();

		String str = '';

		String email = requests[0].email;
		String applicationId = requests[0].applicationId;

		NIIMApplicationHelper.sendApplicationSummary(applicationId, email);

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