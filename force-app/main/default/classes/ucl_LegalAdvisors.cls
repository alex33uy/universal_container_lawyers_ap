public class ucl_LegalAdvisors {
	
	public static void getLegalAdvisorsData() {
		Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
        req.setMethod('GET');
        HttpResponse res = http.send(req);

        // If status code is ok, create a list of objects and desearlize them to get single data
		if (res.getStatusCode() == 200) {
			List<Object> objects = (List<Object>) JSON.deserializeUntyped(res.getBody());
		for (Object obj: objects) {
		Map<String, Object> mapLAdvisorsData = (Map<String, Object>)obj;



		//SOQL call to map if already exist a Record in LegalAdvisors__c with that account number (REQUIREMENT!)
		LegalAdvisors__c legalAdvisorMapped = [SELECT 
                                              Account_Number__c
                                              FROM LegalAdvisors__c WHERE Account_Status__c != 'Disabled' LIMIT 1];

        //SOQL call to map if already exist a Record in Client__c with that Client__ID(sum account number + client number)
		Client__c ClientMapped = [SELECT 
                                  Client_ID__c
                                  FROM Client__c];
	



		// Condition if a Legal Advisor's account number already exists
		if((String)mapLAdvisorsData.get('AccountNumber') == legalAdvisorMapped.Account_Number__c)  {
			
			// Update the existing record with the data from API call
		legalAdvisorMapped.Account_Name__c = (String) mapLAdvisorsData.get('AccountName');
		legalAdvisorMapped.Account_Number__c =  (String) mapLAdvisorsData.get('AccountNumber');
		legalAdvisorMapped.Account_Status__c = (String) mapLAdvisorsData.get('AccountStatus');
		//legalAdvisorMapped.As_of_Date__c = (Date) mapLAdvisorsData.get('AsOfDate');
        List<Object> clients = (List<Object>)mapLAdvisorsData.get('Clients');
		for(object client:clients) {
                Map<String, Object> mapClientsData = (Map<String, Object>)client;

		if( (String) legalAdvisorMapped.Account_Number__c + (String) mapClientsData.get('Client_Number')  == ClientMapped.Client_ID__c) {

			ClientMapped.Client_Number__c = (String) mapClientsData.get('ClientNumber');
			ClientMapped.First_Name__c = (String) mapClientsData.get('FirstName');
			ClientMapped.Last_Name__c = (String) mapClientsData.get('LastName');
			ClientMapped.Address__c = (String) mapClientsData.get('Address');
			ClientMapped.Phone__c = (String) mapClientsData.get('Phone');
			ClientMapped.Email__c = (String) mapClientsData.get('Email');

			update ClientMapped;

			}
		
        
		update legalAdvisorMapped;

		}
	}

		//Condition if a Legal Advisor has status equal to Enabled (REQUIREMENT!)
		if((String) mapLAdvisorsData.get('AccountStatus') == 'Enabled'){
			
		LegalAdvisors__c legalAdvisor = new LegalAdvisors__c();


		legalAdvisor.Account_Name__c = (String) mapLAdvisorsData.get('AccountName');
		legalAdvisor.Account_Number__c =  (String) mapLAdvisorsData.get('AccountNumber');
		legalAdvisor.Account_Status__c = (String) mapLAdvisorsData.get('AccountStatus');
		//legalAdvisor.As_of_Date__c = (Date) mapLAdvisorsData.get('AsOfDate');
		List<Object> clients = (List<Object>)mapLAdvisorsData.get('Clients');
            for(object client:clients){
                Map<String, Object> mapClientsData = (Map<String, Object>)client;
                
                Client__c cl = new Client__c();
                cl.First_Name__c = (string) mapClientsData.get('FirstName');
                cl.Last_Name__c = (string) mapClientsData.get('LastName');
                cl.Email__c = (string) mapClientsData.get('Email');
                cl.Address__c = (string) mapClientsData.get('Address');
                cl.Phone__c = (string) mapClientsData.get('Phone');
                cl.Client_Number__c = (string) mapClientsData.get('ClientNumber');
                cl.Client_ID__c = (String) mapLAdvisorsData.get('AccountNumber') + (string) mapClientsData.get('ClientNumber');
				insert cl;
		}
		insert legalAdvisor;
		}
		

		//Create an error in case something goes wrong
	}

	  }else {
		System.debug('Error when tryng to update or insert new data');
	}


    }
}
