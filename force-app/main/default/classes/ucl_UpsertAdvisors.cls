public with sharing class ucl_UpsertAdvisors {
    @AuraEnabled(cacheable=true) 
    public static void UpsertAdvisors() {
        //http call for response 
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
        req.setMethod('GET');
        HttpResponse res = http.send(req);

        List<LegalAdvisors__c> legalAdvisorsToUpsert = new list<LegalAdvisors__c>();	

        //if status code ok proceed
        if (res.getStatusCode() == 200) {
        List<Object> objects = (List<Object>) JSON.deserializeUntyped(res.getBody());                                  
         for (Object obj: objects) {
        // map to get value and key on advisors
          Map<String, Object> mapLAdvisorsData = (Map<String, Object>)obj;      
        // ckecking advisors status        
                    if((string) mapLAdvisorsData.get('AccountStatus') == 'Enabled') { // unico cambio a testear string en la condicion
                        // mapping data
                       LegalAdvisors__c legalAdvisor = new LegalAdvisors__c();             
                       legalAdvisor.Account_Name__c = (String) mapLAdvisorsData.get('AccountName');
                       legalAdvisor.Name = (String) mapLAdvisorsData.get('AccountName');
                       legalAdvisor.Account_Number__c =  (String) mapLAdvisorsData.get('AccountNumber');
                       legalAdvisor.Account_Status__c = (String) mapLAdvisorsData.get('AccountStatus');
                       string asOfDate = (string) mapLAdvisorsData.get('AsOfDate');
                       String[] dateParts = asOfDate.split('/');
                       Integer year = Integer.valueOf(dateParts[2]);
                       Integer month = Integer.valueOf(dateParts[0]);
                       Integer day = Integer.valueOf(dateParts[1]);
                       legalAdvisor.As_of_Date__c = Date.newInstance(year, month, day);
                       legalAdvisorsToUpsert.add(legalAdvisor);
                }     
            }             
        }
        
        //upsert data or create error
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

