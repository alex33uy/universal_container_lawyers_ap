@isTest
private class ucl_TestUpsertClients {

    @isTest
    static void TestUpsertClients() {

        // Crear un asesor legal para asociar a los clientes
        LegalAdvisors__c legalAdvisor = new LegalAdvisors__c(
            Account_Name__c = 'Test Legal Advisor',
            Account_Number__c = '123',
            Account_Status__c = 'Enabled'
        );

        insert legalAdvisor;

        // Crear un cliente existente (para probar la lógica de eliminación)
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

        // Ejecutar el método UpsertClients
        Test.startTest();
        ucl_UpsertClients.UpsertClients();
        Test.stopTest();

        // Verificar la inserción correcta de clientes
        Integer countClients = [SELECT COUNT() FROM Client__c];
        System.assertEquals(1, countClients, 'Se esperaba un Client__c insertado');

        // Verificar la eliminación correcta de clientes
        Integer countDeletedClients = [SELECT COUNT() FROM Client__c WHERE Id = :existingClient.Id];
        System.assertEquals(0, countDeletedClients, 'Se esperaba que el Client__c existente se eliminara');
    }
}

    @isTest
    global class CalloutMock implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest req){
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type','application/json');
        res.setBody('[{"AccountNumber":"a209ebbb-39c6-4852-8732-82237c0674fb","AccountName":"Fadeo","AccountStatus":"Enabled","AsOfDate":"2/20/2019","Clients":[{"FirstName":"Fran","LastName":"Ruddick","Email":"fruddick0@issuu.com","Phone":"390-285-2477","Address":"434 Maple Drive","ClientNumber":"12afa152-8115-492b-bb49-87399ab49af8"}]}]');
        res.setStatusCode(200);
        return res;
    }
}

     @isTest
     private class CalloutClassTest {
     @isTest static void testCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new CalloutMock());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse res = CalloutClass.getInfoFromExternalService();
        
        // Verify response received contains fake values
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '[{"AccountNumber":"a209ebbb-39c6-4852-8732-82237c0674fb","AccountName":"Fadeo","AccountStatus":"Enabled","AsOfDate":"2/20/2019","Clients":[{"FirstName":"Fran","LastName":"Ruddick","Email":"fruddick0@issuu.com","Phone":"390-285-2477","Address":"434 Maple Drive","ClientNumber":"12afa152-8115-492b-bb49-87399ab49af8"}]}]';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
    }
}

