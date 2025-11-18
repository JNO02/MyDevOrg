public class VehicleInfo {
    public static String makeCallout() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:VehicleInfoApi');
        req.setMethod('GET');
        Integration_Config__mdt cfg = Integration_Config__mdt.getInstance('Vehicle_Info');
        req.setHeader('client-id', cfg.Client_Id__c);
		req.setHeader('client-secret', cfg.Client_Secret__c);
		req.setHeader('correlation-id', cfg.Correlation_Id__c);
        HttpResponse res = http.send(req);
        System.debug('@@@Status Code: ' + res.getStatusCode());
        System.debug('@@@Response Body: ' + res.getBody());
		return res.getBody();
    }
}