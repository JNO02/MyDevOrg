public class OrderItemTriggerHandler {

    public static void handleAfterInsert(List<OrderItem> newItems) {
        Set<Id> orderItemIds = new Set<Id>();

        for (OrderItem oi : newItems) {
            if (oi.IsServiceProductTech__c == false) {
                orderItemIds.add(oi.Id);
            }
        }

        if (!orderItemIds.isEmpty()) {
            AssetCreator.callingVms(orderItemIds);
        }
    }
}