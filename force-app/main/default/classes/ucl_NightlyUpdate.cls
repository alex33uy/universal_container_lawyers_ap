public  class ucl_NightlyUpdate implements Schedulable {
    // future method to call the method that updates the data
    @future(callout=true)
    public static void NightlyCalloutUpdate() {
        ucl_UpdateData.updateData();
    }
    
    // schedule the future method
    public void execute(SchedulableContext sc) {
        try {
           NightlyCalloutUpdate();
        } catch (Exception e) {
            Error_Log__c customError = new Error_Log__c();
            customError.ErrorMessage__c = e.getMessage();
            customError.TimeStamp__c =  DateTime.now();
            insert customError;
            System.debug(e.getMessage());
            
        }
    }
}