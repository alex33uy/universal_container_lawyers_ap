@isTest
private class ucl_TestUpsertClients {
    

    @isTest
    static void TestUpsertClients() {
  
        Test.setMock(HttpCalloutMock.class, new httpMockUp ());
        
        HttpResponse res = ucl_httpRequest.httpRequestCall();
        String expected = '[{"AccountNumbe: 209ebbb-39c6-4852-8732-82237c0674fb","AccountName":"Fadeo","AccountStatus":"Enabled","AsOfDate":"2/20/2019","Clients":[{"FirstName":"Fran","LastName":"Ruddick","Email":"fruddick0@issuu.com","Phone":"390-285-2477","Address":"434 Maple Drive","ClientNumber":"12afa152-8115-492b-bb49-87399ab49af8"}]}]' ;
        
        System.assertEquals(200,res.getStatusCode());
        System.assertEquals(res.getBody(), expected); 

 
        LegalAdvisors__c legalAdvisor = new LegalAdvisors__c(
            Account_Name__c = 'Test Legal Advisor',
            Account_Number__c = '123',
            Account_Status__c = 'Enabled'
        );

        insert legalAdvisor;

        Client__c existingClient = new Client__c(
            First_Name__c = 'Existing',
            Last_Name__c = 'Client',
            Email__c = 'existing@example.com',
            Address__c = '123 Main St',
            Phone__c = '123-456-7890',
            Client_Number__c = '456',
            Legal_Advisor__c = legalAdvisor.Id
        );
        insert existingClient;

        Client__c existingClient2 = new Client__c(
            First_Name__c = 'Existing',
            Last_Name__c = 'Client',
            Email__c = 'existing@example.com',
            Address__c = '123 Main St',
            Phone__c = '123-456-7890',
            Client_Number__c = '456',
            Legal_Advisor__c = legalAdvisor.Id,
            Created_by_Syster_Admin__c = true
        );
        insert existingClient2;


        Test.startTest();
        ucl_UpsertClients.UpsertClients();
        Test.stopTest();
              

 
        Integer countClients = [SELECT COUNT() FROM Client__c];
        System.assertEquals(1, countClients, 'Se esperaba un Client__c insertado');


        Integer countDeletedClients = [SELECT COUNT() FROM Client__c WHERE Id = :existingClient.Id];
        System.assertEquals(0, countDeletedClients, 'Se esperaba que el Client__c existente se eliminara');
    }

    
}


