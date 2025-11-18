trigger TR_OrderItem on OrderItem (after insert) {
    if (Trigger.isAfter && Trigger.isInsert) {
        OrderItemTriggerHandler.handleAfterInsert(Trigger.new);
    }
}