using Toybox.Lang as Lang;
using Toybox.Math as Math; 
using Toybox.UserProfile as UserProfile;


module HeartRateTarget {

const RESTING_ZONE = {
	"title" => "Resting Zone",
	"hex" => 0xffffff
};
const HEART_HEALTHY_ZONE = {
	"title" => "Heart Healthy Zone",
	"hex" => 0x7bff82
};
const WEIGHT_MANAGEMENT_ZONE = {
	"title" => "Weight Management Zone",
	"hex" => 0x7bb5ff
};
const AEROBIC_ZONE = {
	"title" => "Aerobic Zone",
	"hex" => 0xf5ff7b
};
const THRESHOLD_ZONE = {
	"title" => "Aerobic Threshold Zone",
	"hex" => 0xffcd7b
};
const REDLINE_ZONE = {
	"title" => "Redline Zone",
	"hex" => 0xff7b7b
};

function getZoneColors(zones_array){
	var HR_ZONES = {
		0 => RESTING_ZONE,
		zones_array[0] => HEART_HEALTHY_ZONE,
		zones_array[1] => WEIGHT_MANAGEMENT_ZONE,
		zones_array[2] => AEROBIC_ZONE,
		zones_array[3] => THRESHOLD_ZONE,
		zones_array[4] => REDLINE_ZONE
	
	};
	
	return HR_ZONES;

}

}