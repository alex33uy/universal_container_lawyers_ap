public class ucl_ErrorTracker {

    public static void logError(String errorMessage, String stackTrace) {
        // Crea un nuevo registro de Error_Log__c para almacenar el error.
        Error_Log__c errorLog = new Error_Log__c();
        errorLog.ErrorMessage__c = errorMessage;
        errorLog.StackTrace__c = stackTrace;
        errorLog.Timestamp__c =  Datetime.now();

        // Inserta el registro en la base de datos.
        try {
            insert errorLog;
        } catch (Exception e) {
            // Maneja cualquier excepción que pueda ocurrir durante la inserción.
            System.debug('Error al insertar el registro de error: ' + e.getMessage());
        }
    }

}
