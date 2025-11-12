public class AssetCreator {
    
    @future(callout=true)
    public static void callingVms(){
        String resJSON;
        resJSON=VehicleInfo.makeCallout();
        Map<String, Object> ass = (Map<String, Object>)JSON.deserializeUntyped(resJSON);
    }
}