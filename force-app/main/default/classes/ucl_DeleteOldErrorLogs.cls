global class DeleteOldErrorLogs implements Schedulable {

    global void execute(SchedulableContext sc) {
        // Calcula la fecha hace un mes.
        Datetime oneMonthAgo = Datetime.now().addMonths(-1);

        // Elimina los registros de Error_Log__c anteriores a un mes.
        try {
            delete [SELECT Id FROM Error_Log__c WHERE Timestamp__c < :oneMonthAgo];
        } catch (Exception e) {
            // Maneja cualquier excepción que pueda ocurrir durante la eliminación.
            System.debug('Error al eliminar registros antiguos: ' + e.getMessage());
        }
    }

    // Ejecuta este código desde la consola de desarrollador de Apex.
    String cronExp = '0 0 0 * * ?'; // Cada día a medianoche
    String jobID = System.schedule('DeleteOldErrorLogs', cronExp, new DeleteOldErrorLogs());

}
