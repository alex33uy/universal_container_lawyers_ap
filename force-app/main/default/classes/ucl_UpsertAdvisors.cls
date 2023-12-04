public with sharing class ucl_UpsertAdvisors {
    @AuraEnabled(cacheable=true) 
    public static void UpsertAdvisors() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
        req.setMethod('GET');
        HttpResponse res = http.send(req);

        List<LegalAdvisors__c> legalAdvisorsToUpsert = new list<LegalAdvisors__c>();	



        if (res.getStatusCode() == 200) {
        List<Object> objects = (List<Object>) JSON.deserializeUntyped(res.getBody());
                                    
         for (Object obj: objects) {
  
          Map<String, Object> mapLAdvisorsData = (Map<String, Object>)obj;      
                    
                    if((string) mapLAdvisorsData.get('AccountStatus') == 'Enabled') { // unico cambio a testear string en la condicion
                        
                       LegalAdvisors__c legalAdvisor = new LegalAdvisors__c();             
                       legalAdvisor.Account_Name__c = (String) mapLAdvisorsData.get('AccountName');
                       legalAdvisor.Name = 'papas';
                       legalAdvisor.Account_Number__c =  (String) mapLAdvisorsData.get('AccountNumber');
                       legalAdvisor.Account_Status__c = (String) mapLAdvisorsData.get('AccountStatus');
                       //legalAdvisor.As_of_Date__c =  Date.parse( mapLAdvisorsData.get('AsOfDate'));
                        legalAdvisorsToUpsert.add(legalAdvisor);
                }     
            }             
        }  
        try {
            upsert legalAdvisorsToUpsert Account_Number__c;
            
            system.debug('Todo salio bien');
        } catch (DmlException e) {
           Error_Log__c customError = new Error_Log__c();
           customError.ErrorMessage__c = e.getMessage();
            insert customError;
           System.debug(e.getMessage());
         }          
    }
}

