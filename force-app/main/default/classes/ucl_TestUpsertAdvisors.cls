

@isTest
private class ucl_TestUpsertAdvisors {

    @isTest
    static void TestUpsertAdvisors() {
        // Configurar el mock de HTTP para simular una respuesta exitosa
        

        Test.startTest();
        // Ejecutar el método UpsertAdvisors
        ucl_UpsertAdvisors.UpsertAdvisors();
        Test.stopTest();

        // Verificar que los registros LegalAdvisors__c se han insertado correctamente
        Integer countLegalAdvisors = [SELECT COUNT() FROM LegalAdvisors__c];
        System.assertEquals(1, countLegalAdvisors, 'Se esperaba un LegalAdvisors__c insertado');
    }
}

    // Clase mock para simular una respuesta HTTP exitosa
