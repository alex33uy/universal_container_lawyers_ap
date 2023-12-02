public with sharing class ucl_httpRequestAndMappingData {

    public static void ucl_httpRequestAndMappingData() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
        req.setMethod('GET');
        HttpResponse res = http.send(req);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////














        

List<String> accountNumberList = new List<String>();

        

        // If status code is ok, create a list of objects and desearlize them to get single data
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if (res.getStatusCode() == 200) {
		   List<Object> objects = (List<Object>) JSON.deserializeUntyped(res.getBody());
		for (Object obj: objects) {
		   Map<String, Object> mapLAdvisorsData = (Map<String, Object>)obj; //==> devuelve todos los advisors y clients con clave valor
/////////////////////////////////////////////////////////////////////////////////////////////


for(LegalAdvisors__c advisor : newAdvisors){
   accountNumberList.add(advisor.Account_Number__c);
}
        
        
List<LegalAdvisors__c> oldAdvisorList = [SELECT Id, Account_Number__c 
                                        FROM LegalAdvisors__c 
                                        WHERE Account_Number__c 
                                        IN : accountNumberList];










           




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////                                            
LegalAdvisors__c legalAdvisor = new LegalAdvisors__c(); 
legalAdvisor.Account_Name__c = (String) mapLAdvisorsData.get('AccountName');
legalAdvisor.Name = (String) mapLAdvisorsData.get('AccountName');
legalAdvisor.Account_Number__c =  (String) mapLAdvisorsData.get('AccountNumber');
legalAdvisor.Account_Status__c = (String) mapLAdvisorsData.get('AccountStatus');
//legalAdvisor.As_of_Date__c =  Date.parse( mapLAdvisorsData.get('AsOfDate'));
    system.debug(legalAdvisor);// hasta aqui codigo impecable
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////       

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////       
List<Object> clients = (List<Object>)mapLAdvisorsData.get('Clients');
    for(object client:clients){
        Map<String, Object> mapClientsData = (Map<String, Object>)client;
        system.debug(mapClientsData);

        
        Client__c cl = new Client__c();
        cl.First_Name__c = (string) mapClientsData.get('FirstName');
        cl.Last_Name__c = (string) mapClientsData.get('LastName');
        cl.Email__c = (string) mapClientsData.get('Email');
        cl.Address__c = (string) mapClientsData.get('Address');
        cl.Phone__c = (string) mapClientsData.get('Phone');
        cl.Client_Number__c = (string) mapClientsData.get('ClientNumber');
        cl.Legal_Advisor__c = (String) mapLAdvisorsData.get('AccountNumber');
        cl.Name = (string) mapClientsData.get('FirstName') + (string) mapClientsData.get('LastName');// esto tambien solo falta resolver campo externo
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////                
               }
           }
        }
    }
}