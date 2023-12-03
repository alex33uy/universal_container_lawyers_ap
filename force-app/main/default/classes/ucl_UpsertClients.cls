public with sharing class ucl_UpsertClients {
    public static void UpsertClients() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
        req.setMethod('GET');
        HttpResponse res = http.send(req);
	// List that got the clients to upsert
         List<Client__c> ClientsToUpsert = new list<Client__c>();
         
   // list that show the legal advisors
         List<LegalAdvisors__c> legalAdvisors = [Select Id, Account_Number__c
                                                From LegalAdvisors__c];

         

        if (res.getStatusCode() == 200) {
        List<Object> objects = (List<Object>) JSON.deserializeUntyped(res.getBody());
                                    
         for (Object obj: objects) {
         Map<String, Object> mapLAdvisorsData = (Map<String, Object>)obj;      
                    
         if((String) mapLAdvisorsData.get('AccountStatus') == 'Enabled') {
             for(LegalAdvisors__c legalA : legalAdvisors) {
                     if(legalA.Account_Number__c == (string)mapLAdvisorsData.get('AccountNumber')) {
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
                         cl.Legal_Advisor__c = legalA.id ;// si pongo legal advisor id me da null
                         cl.Name = (string) mapClientsData.get('FirstName') + (string) mapClientsData.get('LastName');
                         ClientsToUpsert.add(cl);
                     }
                 }
                }     
            }             
        }
        }
          try {
            upsert ClientsToUpsert;
            system.debug('Todo salio bien con clients');
            system.debug(ClientsToUpsert);
          } catch (DmlException e) {
              Error_Log__c customError = new Error_Log__c();
              customError.ErrorMessage__c = e.getMessage();
              insert customError;
            System.debug(e.getMessage());
          }
        }
    }
