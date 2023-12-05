@isTest
private class ucl_TestDeleteOldErrorLogs{

    @isTest
    static void testExecute() {
        // Create a test Error_Log__c record older than one month
        Error_Log__c testErrorLog = new Error_Log__c(
            ErrorMessage__c = 'Test Error',
            TimeStamp__c = System.now().addMonths(-2)
        );
        insert testErrorLog;

       
        Test.startTest();

        ucl_DeleteOldErrorLogs scheduler = new ucl_DeleteOldErrorLogs();
        scheduler.execute(null);


        Test.stopTest();

        List<Error_Log__c> remainingErrorLogs = [SELECT Id FROM Error_Log__c WHERE Id != :testErrorLog.Id];
        System.assertEquals(0, remainingErrorLogs.size(), 'Old error logs were not deleted.');

        List<Error_Log__c> remainingErrorLogs2 = [SELECT Id FROM Error_Log__c WHERE Id = :testErrorLog.Id];
        System.assertEquals(0, remainingErrorLogs2.size(), 'Old error logs were not deleted.');

        List<Error_Log__c> remainingErrorLogs3 = [SELECT Id FROM Error_Log__c];
        System.assertEquals(0, remainingErrorLogs3.size(), 'Old error logs were not deleted.');



        // Verify that the custom error log was created in case of exception
        List<Error_Log__c> customErrorLogs = [SELECT Id FROM Error_Log__c WHERE ErrorMessage__c != 'Test Error'];
        System.assertEquals(1, customErrorLogs.size(), 'Custom error log was not created.');

        
    }
}



