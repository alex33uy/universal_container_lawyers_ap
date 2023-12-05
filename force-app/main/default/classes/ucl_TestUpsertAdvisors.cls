@isTest
private class ucl_TestUpsertAdvisors {
    @isTest
    static void TestUpsertAdvisors() {
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


        Test.startTest();
        // Ejecutar el método UpsertAdvisors
        ucl_UpsertAdvisors.UpsertAdvisors();
        Test.stopTest();

        // Verificar que los registros LegalAdvisors__c se han insertado correctamente
        Integer countLegalAdvisors = [SELECT COUNT() FROM LegalAdvisors__c];
        System.assertEquals(1, countLegalAdvisors, 'Se esperaba un LegalAdvisors__c insertado');
    }
}

