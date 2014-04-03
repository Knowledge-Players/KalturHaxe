package kalturhaxe;

class KalturaConfiguration{

	public var serviceUrl (default, default):String = "http://www.kaltura.com/";

	public var partnerId (default, default): Int;

	public var format (default, default):Int = 1;

	public var clientTag (default, default):String = "KalturHaxe";

	public var serviceBase (default, default):String = "/api_v3/index.php?service=";

	public function new(partnerId: Int){
		this.partnerId = partnerId;
	}
}