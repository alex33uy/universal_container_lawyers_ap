@isTest
private class ucl_TestNightlyUpdate {

    @isTest
    static void testExecute() {
        // Configurar el mock de SchedulableContext
        Test.startTest();
        Test.setMock(SchedulableContext.class, new ucl_NightlyUpdateTestMock());
        
        // Configurar el mock de ucl_UpsertClients
        
        // Ejecutar el método execute
        ucl_NightlyUpdate nightlyUpdate = new ucl_NightlyUpdate();
        nightlyUpdate.execute(null);
        ucl_NightlyUpdate.NightlyCalloutUpdate();
        Test.stopTest();

        // Verificar que no se lanzaron excepciones
        List<Error_Log__c> errorLogs = [SELECT Id FROM Error_Log__c];
        System.assertEquals(0, errorLogs.size(), 'No debería haber errores registrados');
    }

    // Clase mock para simular SchedulableContext
    private class ucl_NightlyUpdateTestMock implements SchedulableContext {
        public String getTriggerId() {
            return null;
        }
        public Map<String, Object> getTriggerContext() {
            return null;
        }
        public String getCronTriggerId() {
            return null;
        }
    }
}