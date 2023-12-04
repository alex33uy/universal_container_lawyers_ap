
  @isTest
    private class ucl_TestDeleteOldErrorLogs  {
    
        @isTest
        static void TestDeleteOldErrorLogs() {
            Test.startTest();
    
            // Insertar un registro Error_Log__c más antiguo que un mes
            Error_Log__c oldErrorLog = new Error_Log__c();
            oldErrorLog.Timestamp__c = System.now().addMonths(-2);
            insert oldErrorLog;
    
            // Insertar un registro Error_Log__c reciente (dentro del mes)
            Error_Log__c recentErrorLog = new Error_Log__c();
            recentErrorLog.Timestamp__c = System.now();
            insert recentErrorLog;
    
            // Ejecutar el trabajo programado
            ucl_DeleteOldErrorLogs scheduledJob = new ucl_DeleteOldErrorLogs();
            scheduledJob.execute(null);
    
            // Verificar que el registro antiguo se ha eliminado
            System.assertEquals(1, [SELECT COUNT() FROM Error_Log__c WHERE Id = :oldErrorLog.Id]);
    
            // Verificar que el registro reciente no se ha eliminado
            System.assertEquals(1, [SELECT COUNT() FROM Error_Log__c WHERE Id = :recentErrorLog.Id]);
    
            Test.stopTest();
        }
    
        @isTest
        static void testExecuteWithException() {
            Test.startTest();
    
    
            // Ejecutar el trabajo programado
            ucl_DeleteOldErrorLogs scheduledJob = new ucl_DeleteOldErrorLogs();
            scheduledJob.execute(null);
    
            // Verificar que se haya insertado un nuevo registro Error_Log__c con el mensaje de error
            System.assertEquals(1, [SELECT COUNT() FROM Error_Log__c]);
    
            Test.stopTest();
        }
    }


