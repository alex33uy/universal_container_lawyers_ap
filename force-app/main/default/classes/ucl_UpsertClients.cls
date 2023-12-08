public with sharing class ucl_UpsertClients {

    
    public static void UpsertClients(HttpResponse res) {

      // creating list to fullfill with clients to upsert
       List<Client__c> ClientsToUpsert = new list<Client__c>();
       
       
       // query all legal advisors
       List<LegalAdvisors__c> legalAdvisors = [Select Id, Account_Number__c
                                              From LegalAdvisors__c];

      if (res.getStatusCode() == 200) {
      List<Object> objects = (List<Object>) JSON.deserializeUntyped(res.getBody());
                                  
       for (Object obj: objects) {
       Map<String, Object> mapLAdvisorsData = (Map<String, Object>)obj;      
           // looking if account status is enabled       
       if((String) mapLAdvisorsData.get('AccountStatus') == 'Enabled') {
        // iterating over the existing legal advisors
           for(LegalAdvisors__c legalA : legalAdvisors) {
        // checking that the legal account that is inserted is the correct legal account to insert their clients
            if(legalA.Account_Number__c == (string)mapLAdvisorsData.get('AccountNumber')) {

           List<Object> clients = (List<Object>)mapLAdvisorsData.get('Clients');
           for(object client:clients){
           Map<String, Object> mapClientsData = (Map<String, Object>)client;
               
           // mapping data to clients fields            
                       Client__c cl = new Client__c();
                       cl.First_Name__c = (string) mapClientsData.get('FirstName');
                       cl.Last_Name__c = (string) mapClientsData.get('LastName');
                       cl.Email__c = (string) mapClientsData.get('Email');
                       cl.Address__c = (string) mapClientsData.get('Address');
                       cl.Phone__c = (string) mapClientsData.get('Phone');
                       cl.Client_Number__c = (string) mapClientsData.get('ClientNumber');
                       cl.Legal_Advisor__c = legalA.id;
                       cl.Name = (string) mapClientsData.get('FirstName') + ' ' + (string) mapClientsData.get('LastName');
                       cl.General_ID__c = legalA.Account_Number__c + (string) mapClientsData.get('ClientNumber');
                       ClientsToUpsert.add(cl);
                   }
               }
              }     
          }             
      }
      }

//Creating a list that stores the client numbers
List<String> ClientNumbers = new List<String>();
for(Client__c c : ClientsToUpsert) {
  ClientNumbers.add(c.Client_Number__c);
}

//Create a query thas looks for the numbers that are in not ClientsToUpsert
List<Client__c> ClientsNotInJson = [SELECT id, Client_Number__c, Created_by_Syster_Admin__c, Name  FROM Client__c WHERE Client_Number__c NOT IN : ClientNumbers
                                   AND Created_by_Syster_admin__c = false];


//execute the dmls or create a new error
        try {
          upsert ClientsToUpsert General_ID__c;
          delete ClientsNotInJson;
          system.debug('Todo salio bien con clients');
        } catch (DmlException e) {
            Error_Log__c customError = new Error_Log__c();
            customError.ErrorMessage__c = e.getMessage();
            customError.TimeStamp__c =  DateTime.now();
            insert customError;
          System.debug(e.getMessage());
        }
        }
    }
