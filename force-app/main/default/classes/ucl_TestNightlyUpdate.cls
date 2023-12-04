@isTest
private class ucl_NightlyUpdate_Test {

    @isTest
    static void testNightlyCalloutUpdateSuccess() {
        // Arrange
        Test.startTest();

        // Act
        ucl_NightlyUpdate.NightlyCalloutUpdate();

        // Assert
        // Add assertions based on the expected behavior in a success case

        Test.stopTest();
    }

    @isTest
    static void testNightlyCalloutUpdateException() {
        // Arrange
        Test.startTest();
        // Mock a scenario where UpsertClients method throws an exception
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorException());

        // Act
        ucl_NightlyUpdate.NightlyCalloutUpdate();

        // Assert
        // Verify that the exception is caught and logged to Error_Log__c

        Test.stopTest();
    }

    @isTest
    static void testExecuteSuccess() {
        // Arrange
        Test.startTest();
        // Mock a scenario where NightlyCalloutUpdate executes successfully
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorSuccess());

        // Act
        ucl_NightlyUpdate scheduler = new ucl_NightlyUpdate();
        scheduler.execute(null); // Pass null for SchedulableContext

        // Assert
        // Add assertions based on the expected behavior in a success case

        Test.stopTest();
    }

    @isTest
    static void testExecuteException() {
        // Arrange
        Test.startTest();
        // Mock a scenario where NightlyCalloutUpdate throws an exception
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorException());

        // Act
        ucl_NightlyUpdate scheduler = new ucl_NightlyUpdate();
        scheduler.execute(null); // Pass null for SchedulableContext

        // Assert
        // Verify that the exception is caught and logged to Error_Log__c

        Test.stopTest();
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