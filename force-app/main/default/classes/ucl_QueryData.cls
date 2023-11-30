public with sharing class ucl_QueryData {

    @AuraEnabled(cacheable=true)
    public static List<LegalAdvisors__c> showLegalAdvisorData() {
        List<LegalAdvisors__c> la= [SELECT Account_Name__c,
                                     Account_Number__c,
                                     Account_Status__c, 
                                     As_Of_Date__c 
                                     FROM LegalAdvisors__c WHERE Account_Status__c != 'Disabled'];
         system.debug(la);
         return(la);
    }

    @AuraEnabled(cacheable=true)
    public static List<Client__c> showClientData() {
        List<Client__c> lc =  [SELECT  First_Name__c,
                                       Client_Number__c,
                                       Last_Name__c, 
                                       Email__c, 
                                       Phone__c, 
                                       Address__c 
                                       //ID_client_contract__c 
                                       FROM Client__c];
         system.debug(lc);
         return(lc);
    }
}