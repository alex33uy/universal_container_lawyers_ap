public  class ucl_NightlyUpdate implements Schedulable {
    
    public void execute(SchedulableContext sc) {
        try {
            ucl_UpsertClients.UpsertClients();
        } catch (Exception e) {
            Error_Log__c customError = new Error_Log__c();
            customError.ErrorMessage__c = e.getMessage();
            customError.TimeStamp__c =  DateTime.now();
            insert customError;
            System.debug(e.getMessage());
            
        }
    }
}