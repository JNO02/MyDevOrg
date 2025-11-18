public class AssetCreator {

    public class AssetEntry {
        Id orderItemId;
        Id accountId;
        Id contactId;
        String productName;
		Boolean One_Year_Truck_Service;
    }
    
    @future(callout=true)
    public static void callingVms(Set<Id> orderItemIds) {

        if (orderItemIds == null || orderItemIds.isEmpty()) 
            return;

        Map<Id, OrderItem> oiMap = new Map<Id, OrderItem>(
            [
                SELECT Id,
                       Quantity,
                       Product2.Name,
                       Order.Quote.AccountId,
                       Order.Quote.ContactId,
					   IsOneYearServiceAdd__c
                FROM OrderItem
                WHERE Id IN :orderItemIds
            ]
        );

        List<AssetEntry> entries = new List<AssetEntry>();

       
        for (OrderItem oi : oiMap.values()) {

            Integer qty = Integer.valueOf(oi.Quantity);

            for (Integer i = 0; i < qty; i++) {
                AssetEntry e = new AssetEntry();
                e.orderItemId = oi.Id;
                e.accountId = oi.Order.Quote != null ? oi.Order.Quote.AccountId : null;
                e.contactId = oi.Order.Quote != null ? oi.Order.Quote.ContactId : null;
                e.productName = oi.Product2 != null ? oi.Product2.Name : 'Asset';
				e.One_Year_Truck_Service = oi.IsOneYearServiceAdd__c;
                entries.add(e);
            }
        }

        List<Asset> assetsToInsert = new List<Asset>();

        
        for (AssetEntry e : entries) {

            String resJSON = VehicleInfo.makeCallout();
            if (String.isBlank(resJSON))
                continue;

            AssetWrapper data = AssetWrapper.parse(resJSON);
            if (data == null || String.isBlank(data.vin)) 
                continue;

            Asset a = new Asset();
            a.VIN__c = data.vin;
            a.Order_Product__c = e.orderItemId;
            a.AccountId = e.accountId;
            a.ContactId = e.contactId;
            a.Name = e.productName;
			a.One_Year_Truck_Service__c = e.One_Year_Truck_Service;
            if (!String.isBlank(data.vehicleNum))
                a.vehicleNum__c = data.vehicleNum;

            if (!String.isBlank(data.regNumCountryKey))
                a.regNumCountryKey__c = data.regNumCountryKey;

            assetsToInsert.add(a);
        }

        if (!assetsToInsert.isEmpty()) {
            insert assetsToInsert;
        }
    }
}