public class VehicleInfo {
    public static void makeCallout() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        
     
        req.setEndpoint('callout:VehicleInfoApi/man-el-vis-int/v1/vehicles/WMAL36ZZZ1Y076935/information-system?company-id=DE0720&language=DE');
        req.setMethod('GET');
        
       
        req.setHeader('client-id','d657ac3358794331b8913918ff1f6018');
        req.setHeader('client-secret', '424eACa84e944f23a0BB171682245059');
        req.setHeader('correlation-id', 'b7fdbb57-1e81-4ea1-8eb4-a038692f1982');
        
        HttpResponse res = http.send(req);
        
        System.debug('@@@Status Code: ' + res.getStatusCode());
        System.debug('@@@Response Body: ' + res.getBody());
    }
}