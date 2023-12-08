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
        System.assertEquals(1, remainingErrorLogs.size(), 'Old error logs were not deleted.');

        List<Error_Log__c> remainingErrorLogs3 = [SELECT Id FROM Error_Log__c WHERE Id = :testErrorLog.Id];
        System.assertEquals(0, remainingErrorLogs3.size(), 'Old error logs were deleted.');

         

        // Verify that the custom error log was created in case of exception
        List<Error_Log__c> customErrorLogs = [SELECT Id FROM Error_Log__c WHERE ErrorMessage__c != 'Test Error'];
        System.assertEquals(1, customErrorLogs.size(), 'Custom error log was not created.');

        
    }

    static void testExecute2() {
        // Create newest error to test
        Error_Log__c testErrorLogNew = new Error_Log__c(
            ErrorMessage__c = 'New Error 2',
            TimeStamp__c = System.now().addMonths(+1)
        );
        insert testErrorLogNew;

        Test.startTest();

        ucl_DeleteOldErrorLogs scheduler = new ucl_DeleteOldErrorLogs();
        scheduler.execute(null);


        Test.stopTest();

        List<Error_Log__c> remainingErrorLogs4 = [SELECT Id FROM Error_Log__c WHERE Id != :testErrorLogNew.Id];
        System.assertEquals(0, remainingErrorLogs4.size(), 'Old error logs were deleted.');

        List<Error_Log__c> remainingErrorLogs2 = [SELECT Id FROM Error_Log__c WHERE Id = :testErrorLogNew.Id];
        System.assertEquals(1, remainingErrorLogs2.size(), 'Old error logs were deleted.');

        List<Error_Log__c> customErrorLogs2 = [SELECT Id FROM Error_Log__c WHERE ErrorMessage__c = 'Test Error'];
        System.assertEquals(0, customErrorLogs2.size(), 'Custom error log was not created.');

    }
}



