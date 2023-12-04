global class ucl_DeleteOldErrorLogs implements Schedulable {

    global void execute(SchedulableContext sc) {
        
        Datetime oneMonthAgo = Datetime.now().addMonths(-1);

        // delete all errors that are older than a month
        try {
            delete [SELECT Id FROM Error_Log__c WHERE Timestamp__c < :oneMonthAgo];
            system.debug('Deleted old records succesfully');
        } catch (Exception e) {
            // handle exceptions during excecution
            Error_Log__c customError = new Error_Log__c();
            customError.ErrorMessage__c = e.getMessage();
            customError.TimeStamp__c =  DateTime.now();
            insert customError;
            System.debug(e.getMessage());
            
            System.debug('Error al eliminar registros antiguos: ' + e.getMessage());
        }
    }
}
