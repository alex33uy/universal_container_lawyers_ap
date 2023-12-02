public class ucl_LegalAdvisors {
	@AuraEnabled(cacheable=true)
	public static void getLegalAdvisorsData() {
		Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
        req.setMethod('GET');
        HttpResponse res = http.send(req);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // If status code is ok, create a list of objects and desearlize them to get single data
		if (res.getStatusCode() == 200) {
		   List<Object> objects = (List<Object>) JSON.deserializeUntyped(res.getBody());
            List<String> accountNumberList = new List<String>(); // unica linea agregada que esta a prueba
		   List<LegalAdvisors__c> oldAdvisorList = [SELECT Id, Account_Number__c, Account_Status__c 
                                        FROM LegalAdvisors__c 
                                        WHERE Account_Number__c 
                                        IN : accountNumberList];// hasta aqui agregado de prueba
            system.debug(oldAdvisorList);
            for (Object obj: objects) {
		   Map<String, Object> mapLAdvisorsData = (Map<String, Object>)obj;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            if ((String) mapLAdvisorsData.get('AccountStatus') == 'Enabled') {
                
                for(LegalAdvisors__c oldAdvisor: oldAdvisorList) {
                if(oldAdvisor.Account_Number__c == (String) mapLAdvisorsData.get('AccountNumber')) {
                    system.debug(oldAdvisor);
                    oldAdvisor.Account_Name__c = 'MAn';
                    oldAdvisor.Name = (String) mapLAdvisorsData.get('AccountName');
		            oldAdvisor.Account_Number__c =  (String) mapLAdvisorsData.get('AccountNumber');
		            oldAdvisor.Account_Status__c = (String) mapLAdvisorsData.get('AccountStatus');
                    //oldAdvisor.As_of_Date__c =  Date.parse( mapLAdvisorsData.get('AsOfDate'));
                    update oldAdvisor;
                    accountNumberList.add(OldAdvisor.Account_Number__c);
                    
                }
                    
                          
                }
            
                                                      
       
            
          
            
            
            }
          
         }
 }
	}
    }

