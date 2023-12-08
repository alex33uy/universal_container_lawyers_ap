@isTest
private class ucl_TestNightlyUpdate {

    @isTest
    static void testNightlyCalloutUpdateSuccess() {
        Test.startTest();

        ucl_NightlyUpdate.NightlyCalloutUpdate();

        Test.stopTest();
    }

    @isTest
    static void testNightlyCalloutUpdateException() {
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new  httpMockUp());
        ucl_NightlyUpdate.NightlyCalloutUpdate();
        Test.stopTest();
    }

    @isTest
    static void testExecuteSuccess() {
        
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new httpMockUp());

        ucl_NightlyUpdate scheduler = new ucl_NightlyUpdate();
        scheduler.execute(null); 

        Test.stopTest();
    }

    @isTest
    static void testExecuteException() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new httpMockUp());

        ucl_NightlyUpdate scheduler = new ucl_NightlyUpdate();
        scheduler.execute(null);


        Test.stopTest();
    }
}