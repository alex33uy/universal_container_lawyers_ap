public with sharing class ucl_httpRequest {
    public static  HttpResponse httpRequestCall() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        return res;
    }
}