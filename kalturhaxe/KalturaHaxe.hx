package kalturhaxe;

import kalturhaxe.KalturaResponseTypes;
import haxe.Json;

import kalturhaxe.KalturaResponseTypes.FlavorAssetResponse;
import kalturhaxe.service.KalturaSession.KalturaSessionType;

class KalturaHaxe{

	var partnerId: Int;
	var client: KalturaClient;

	public function new(?partnerId:Int, ?serviceUrl: String = "http://www.kaltura.com/", ?ks: String){
		this.partnerId = partnerId;
		var config = new KalturaConfiguration(partnerId);
		config.serviceUrl = serviceUrl;
		client = new KalturaClient(config);
		if(ks != null)
			client.ks = ks;
	}

	///
	// API
	//

	public function createConnection(secret:String, ?userId: String = "", ?sessionType:KalturaSessionType, ?expiry: Int = 86400, ?privileges: String, callback: Bool -> String -> Void):Void
	{
		var type = sessionType != null ? sessionType : KalturaSessionType.USER;

		client.session.start(function(success, result: String){
			if(success)
				client.ks = result.substr(1, result.length-2);
			callback(success, result);
		}, secret, userId, type, partnerId, expiry, privileges);
	}

	public function getBitrateWiseAsset(entryId:String, bitrate: Float, ?storageId: String, ?forceProxy: Bool = false, callback:Bool -> String -> Void):Void
	{
		client.flavorAsset.getEntryById(function(success, result){
			//trace("callback1: ", success);
			if(!success){
				//js.Lib.alert(client.ks+", "+entryId+", "+result);
				callback(success, result);
			}
			var res = Json.parse(result);
			//trace(res);
			var a = new Array<FlavorAssetResponse>();
			for(f in Reflect.fields(res))
				//trace(f);
				a.push(KalturaResponseTypes.createFlavorAssetResponse(Reflect.field(res, f)));

			var asset = selectByBitrate(a, bitrate);
			client.flavorAsset.getUrl(function(success, result){
				callback(success, result);
			}, asset.id, storageId, forceProxy);
		}, entryId);
	}

	///
	// Internals
	//

	private function selectByBitrate(candidates: Array<FlavorAssetResponse>, targetedBitrate: Float):FlavorAssetResponse
	{
		candidates.sort(function(e1, e2){
			if(e1.bitrate < e2.bitrate)
				return 1;
			else
				return -1;
		});

		var i = 0;
		while(i < candidates.length && candidates[i].bitrate > targetedBitrate)
			i++;

		if(i == candidates.length)
			return candidates[i-1];
		else
			return candidates[i];
	}
}