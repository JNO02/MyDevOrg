trigger TR_OrderItem on OrderItem (after insert) {

    if (Trigger.isAfter && Trigger.isInsert) {

        Set<Id> orderItemIds = new Set<Id>();

        for (OrderItem oi : Trigger.new) {
            if (oi.IsServiceProductTech__c == false) {
                orderItemIds.add(oi.Id);
            }
        }

        if (!orderItemIds.isEmpty()) {
            AssetCreator.callingVms(orderItemIds);
        }
    }
}