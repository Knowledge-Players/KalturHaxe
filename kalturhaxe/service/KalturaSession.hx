package kalturhaxe.service;

import kalturhaxe.KalturaClient;

import haxe.ds.StringMap;

enum KalturaSessionType {
	USER;
	ADMIN;
}

class KalturaSession{

	public var type (default, default): KalturaSessionType;

	var client: KalturaClient;

	public function new(client: KalturaClient){
		this.client = client;
	}

	public function start(callback:Bool -> String -> Void, secret:String, ?userId:String = "", ?type:KalturaSessionType, ?partnerId:Int, ?expiry:Int = 86400, ?privileges:String):Void
	{
		var kparams = new StringMap<String>();
		RequestTools.addParam(kparams, "secret", Native(secret));
		RequestTools.addParam(kparams, "userId", Native(userId));
		RequestTools.addParam(kparams, "type", Native(Std.string(type)));
		RequestTools.addParam(kparams, "partnerId", Native(Std.string(partnerId)));
		RequestTools.addParam(kparams, "expiry", Native(Std.string(expiry)));
		RequestTools.addParam(kparams, "privileges", Native(privileges));

		client.queueServiceActionCall("session", "start", kparams);
		if (!client.useMultiRequest)
			client.doQueue(callback);
	}


}