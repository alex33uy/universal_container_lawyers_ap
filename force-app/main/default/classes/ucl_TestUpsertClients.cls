@isTest
private class ucl_TestUpsertClients {

    @isTest
    static void TestUpsertClients() {
        // Configurar el mock de HTTP para simular una respuesta exitosa
        

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

        // Verificar el debug se llamó correctamente

    }

    // Clase mock para simular una respuesta HTTP exitosa

}
