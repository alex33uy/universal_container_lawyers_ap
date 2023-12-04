public with sharing class ucl_UpsertClients {
    @AuraEnabled(cacheable=true) 
    public static void UpsertClients() {
      
      Http http = new Http();
      HttpRequest req = new HttpRequest();
      req.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
      req.setMethod('GET');
      HttpResponse res = http.send(req);

      ucl_UpsertAdvisors.UpsertAdvisors();

       List<Client__c> ClientsToUpsert = new list<Client__c>();
       List<Client__c> ClientsToDelete = new list<Client__c>();
       
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
                       cl.Legal_Advisor__c = legalA.id;
                       cl.Name = (string) mapClientsData.get('FirstName') + ' ' + (string) mapClientsData.get('LastName');
                       ClientsToUpsert.add(cl);
                   }
               }
              }     
          }             
      }
      }

List<String> ClientNumbers = new List<String>();
for(Client__c c : ClientsToUpsert) {
  ClientNumbers.add(c.Client_Number__c);
}

List<Client__c> ClientsNotInJson = [SELECT id, Client_Number__c, Created_by_Syster_Admin__c, Name  FROM Client__c WHERE Client_Number__c NOT IN : ClientNumbers];
for(Client__c ClientToDelete : ClientsNotInJson) {
    if(!ClientToDelete.Created_by_Syster_Admin__c) {
        ClientsToDelete.add(ClientToDelete);
    }
}
system.debug(ClientsToDelete);

        try {
          upsert ClientsToUpsert Client_Number__c;
          delete ClientsToDelete;
          system.debug('Todo salio bien con clients');
        } catch (DmlException e) {
            Error_Log__c customError = new Error_Log__c();
            customError.ErrorMessage__c = e.getMessage();
            insert customError;
          System.debug(e.getMessage());
        }
        }
    }
