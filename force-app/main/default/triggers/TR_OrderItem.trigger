trigger TR_OrderItem on OrderItem (after insert) {

    if(trigger.IsAfter && trigger.IsInsert){
        for(OrderItem OI:trigger.new){
            AssetCreator.callingVms(OI.Id);
        }

}
}