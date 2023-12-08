public with sharing class ucl_UpdateData {
    @AuraEnabled
    public static void updateData() {    
        HttpResponse res = ucl_httpRequest.httpRequestCall();
        ucl_UpsertAdvisors.UpsertAdvisors(res);
        ucl_UpsertClients.UpsertClients(res);
    }
}