public class AssetWrapper {
    public String vin;
    public String vehicleNum;
    public String regNumCountryKey;
    public String manufacturer;
    public String prodCode;
    public String modelRange;
    public String modelRangeAvis;
    public String vehicleType;
    public String typeVariant;
    public String modelType;
    public String deliveryExWorkDate;
    public String firstRegDate;
    public String wheelBase;
    public String suspension;
    public String unitMaxWeightAllowed;
    public String truckAxle;
    public String customerRegDate;
    public String customerNo;
    public String customerName;
    public String vehicleOrderNum;
    public measuringPoint measuringPoint;
    public List<warranty> warranty;
    public vehicleAggregate vehicleAggregate;
    public maintenance maintenance;

    public class measuringPoint {
        public String measPoint;
        public String counterReading;
        public String mpUnit;
    }

    public class warranty {
        public String type;
        public String typeText;
        public String internalNumber;
        public String reasonText;
        public String totalMilageUnit;
        public String totalMilageFrom;
        public String wholeMilage;
        public String diffMilage;
        public String diffMilage1;
        public String conditionStartDate;
        public String conditionEndDate;
        public String stateOfWarranty;
        public String text2;
        public String text3;
        public String text4;
        public String fromValue;
        public String toValue;
    }

    public class standard {
        public String vin;
        public String aggUnitDesc;
        public String aggUnitkey;
        public String typeDescription;
        public String manufSerialNo;
        public String manufacturer;
        public String installationDate;
    }

    public class motor {
        public String vin;
        public String aggUnitDesc;
        public String aggUnitkey;
        public String typeDescription;
        public String manufSerialNo;
        public String manufacturer;
        public String enginePower;
        public String cubicCapacity;
        public String cubicCapacityUnit;
        public String installationDate;
        public String enginePower1;
        public String enginePowerUnit1;
        public String emissionClass;
    }

    public class gearbox {
        public String vin;
        public String aggUnitDesc;
        public String aggUnitkey;
        public String typeDescription;
        public String manufSerialNo;
        public String installationDate;
        public String noGears;
    }

    public class cab {
        public String vin;
        public String aggUnitDesc;
        public String aggUnitkey;
        public String typeDescription;
        public String manufacturer;
        public String installationDate;
        public String colour;
    }

    public class steering {
        public String vin;
        public String aggUnitDesc;
        public String aggUnitkey;
        public String typeDescription;
        public String installationDate;
        public String steerControl;
    }

    public class tachometer {
        public String vin;
        public String aggUnitDesc;
        public String aggUnitkey;
        public String typeDescription;
        public String manufSerialNo;
        public String manufacturer;
        public String installationDate;
    }

    public class tankBody {
        public String vin;
        public String aggUnitDesc;
        public String aggUnitkey;
        public String typeDescription;
        public String manufacturer;
        public String installationDate;
    }

    public class vehicleAggregate {
        public List<standard> standard;
        public motor motor;
        public gearbox gearbox;
        public cab cab;
        public steering steering;
        public tachometer tachometer;
        public tankBody tankBody;
    }

    public class customerRequest {
        public String objectCode1;
        public String objectCode2;
        public String version;
        public String location;
    }

    public class plan {
        public String vin;
        public String mpType;
        public String salesOrg;
        public String serviceCode;
        public String serviceCodeDesc;
        public String lastMaintKM;
        public String nextMaintDate;
        public String nextMaintKM;
        public customerRequest customerRequest;
    }

    public class maintenance {
        public List<plan> plan;
    }
    public static AssetWrapper parse(String json) {
        return (AssetWrapper) System.JSON.deserialize(json, AssetWrapper.class);
    }
}