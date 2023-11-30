public class ucl_LegalAdvisors {
	
	@AuraEnabled(cacheable=true)
	public static LegalAdvisors__c getLegalAdvisorsData() {
		Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
        req.setMethod('GET');
        HttpResponse res = http.send(req);

		LegalAdvisors__c legalAdvisor = new LegalAdvisors__c();

		if (res.getStatusCode() == 200) {
			List<Object> objects = (List<Object>) JSON.deserializeUntyped(res.getBody());
		for (Object obj: objects) {
		Map<String, Object> mapLAdvisorsData = (Map<String, Object>)obj;
		
		

		// Condition if a Legal Advisor's account number already exists
		if((String)mapLAdvisorsData.get('AccountNumber') == legalAdvisor.Account_Number__c)  {
		update legalAdvisor;
		}

		//Condition if a Legal Advisor has status as disabled
		if((String) mapLAdvisorsData.get('AccountStatus') != 'Disabled'){
		legalAdvisor.Account_Name__c = (String) mapLAdvisorsData.get('AccountName');
		legalAdvisor.Account_Number__c =  (String) mapLAdvisorsData.get('AccountNumber');
		legalAdvisor.Account_Status__c = (String) mapLAdvisorsData.get('AccountStatus');
		legalAdvisor.As_Of_Date__c = (Date) mapLAdvisorsData.get('AsOfDate');
		insert legalAdvisor;
		}
		
		}

	  } else {
		System.debug('Error !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
	  }
	  return legalAdvisor;
	}


}
