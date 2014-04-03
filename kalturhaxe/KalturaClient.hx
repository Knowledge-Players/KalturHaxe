package kalturhaxe;

import kalturhaxe.service.KalturaFlavorAssetService;
import kalturhaxe.service.KalturaSession;
import haxe.ds.StringMap;

typedef KalturaServiceActionCall = {
	var params: StringMap<String>;
	var files: StringMap<String>;
	var service: String;
	var action: String;
}

class KalturaClient{

	public var session (default, default):KalturaSession;
	public var flavorAsset (default, default):KalturaFlavorAssetService;
	public var useMultiRequest (default, null): Bool = false;
	public var ks: String = "";

	static inline var apiVersion: String = "3.1.6";

	var config: KalturaConfiguration;
	var callsQueue: List<KalturaServiceActionCall>;

	public function new(config: KalturaConfiguration){
		this.config = config;
		callsQueue = new List();
		session = new KalturaSession(this);
		flavorAsset = new KalturaFlavorAssetService(this);
	}

	public function queueServiceActionCall(service:String, action:String, params:StringMap<String>, ?files:StringMap<String>):Void
	{
		if(!params.exists("partnerId") || params.get("partnerId") == "-1")
			params.set("partnerId", Std.string(config.partnerId));

		RequestTools.addParam(params, "ks", Native(ks));

		var call: KalturaServiceActionCall = {service: service, action: action, params: params, files: files != null ? files: new StringMap()};
		callsQueue.add(call);
	}

	public function doQueue(callback:Bool -> String -> Void):Void
	{
		if (callsQueue.length == 0)
			return;

		var params = new StringMap<String>();
		var files = new StringMap<String>();

		// append the basic params
		RequestTools.addParam(params, "apiVersion", Native(apiVersion));
		RequestTools.addParam(params, "format", Native(Std.string(config.format)));
		RequestTools.addParam(params, "clientTag", Native(config.clientTag));

		var url = config.serviceUrl + this.config.serviceBase;
		var call: KalturaServiceActionCall = null;
		/*if (this.useMultiRequest){
			url += "multirequest";
			$i = 1;
			for(var v in this.callsQueue){
			call = this.callsQueue[v];
			var callParams = call.getParamsForMultiRequest($i);
			for(var sv1 in callParams)
			params[sv1] = callParams[sv1];
			var callFiles = call.getFilesForMultiRequest($i);
			for(var sv2 in callFiles)
			files[sv2] = call.files[sv2];
			$i++;
			}
		} else {*/
			call = callsQueue.first();
			url += call.service + "&action=" + call.action;
			for(sv3 in call.params.keys())
				params.set(sv3, call.params.get(sv3));
			for(sv4 in call.files.keys())
				files.set(sv4, call.files.get(sv4));
		//}
		// reset
		callsQueue = new List();
		useMultiRequest = false;
		var signature = sign(params);
		RequestTools.addParam(params, "kalsig", Native(signature));

		RequestTools.executeRequest(callback, url, params, files);
	}

	private function sign(params:StringMap<String>):String
	{
		var str = new StringBuf();
		for(k in params.keys()) {
			var v = params.get(k);
			str.add(v);
			str.add(k);
		}
		return haxe.crypto.Md5.encode(str.toString());
	}
}