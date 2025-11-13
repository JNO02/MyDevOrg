public class AssetCreator {
    
    // TODO: Consider migrating to Queueable for better control and chaining instead of @future
    @future(callout=true)
    public static void callingVms(){
        String resJSON;
        try {
            resJSON = VehicleInfo.makeCallout();
            if (String.isBlank(resJSON)) {
                System.debug(LoggingLevel.WARN, 'AssetCreator.callingVms: Empty response from VehicleInfo.makeCallout()');
                return;
            }
            
            AssetWrapper assetObj = AssetWrapper.parse(resJSON);
            if (assetObj == null) {
                System.debug(LoggingLevel.ERROR, 'AssetCreator.callingVms: Failed to parse response into AssetWrapper.');
                return;
            }

            // Validate minimal keys (VIN identifies the Asset)
            if (String.isBlank(assetObj.vin)) {
                System.debug(LoggingLevel.ERROR, 'AssetCreator.callingVms: VIN missing in response, cannot upsert Asset. Payload=' + resJSON);
                return;
            }

            // Prepare Asset for upsert. If VIN__c is an External ID, this prevents duplicates.
            Asset assetToUpsert = new Asset();
            assetToUpsert.VIN__c = assetObj.vin;

            // Assign only non-blank values to avoid overwriting existing values with blanks
            if (!String.isBlank(assetObj.vehicleNum)) {
                assetToUpsert.vehicleNum__c = assetObj.vehicleNum;
            }
            if (!String.isBlank(assetObj.regNumCountryKey)) {
                assetToUpsert.regNumCountryKey__c = assetObj.regNumCountryKey;
            }

            try {
                // Prefer upsert by External ID field; adjust if VIN__c is not External ID in your org
                upsert assetToUpsert VIN__c;
                System.debug(LoggingLevel.INFO, 'AssetCreator.callingVms: Upserted Asset by VIN__c=' + assetObj.vin);
            } catch (DmlException dmx) {
                System.debug(LoggingLevel.ERROR, 'AssetCreator.callingVms: DML error upserting Asset. VIN=' + assetObj.vin + ', msg=' + dmx.getMessage());
            }
        } catch (CalloutException cx) {
            System.debug(LoggingLevel.ERROR, 'AssetCreator.callingVms: Callout error: ' + cx.getMessage());
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR, 'AssetCreator.callingVms: Unexpected error: ' + ex.getMessage());
        }
    }
}
