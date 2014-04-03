package kalturhaxe.service;

import kalturhaxe.KalturaClient;
import kalturhaxe.RequestTools;

import haxe.ds.StringMap;

class KalturaFlavorAssetService{

	var client: KalturaClient;

	public function new(client: KalturaClient){
		this.client = client;
	}

	public function getEntryById(callback:Bool -> String -> Void, entryId: String):Void
	{
		var kparams = new StringMap<String>();
		RequestTools.addParam(kparams, "entryId", Native(entryId));
		client.queueServiceActionCall("flavorasset", "getByEntryId", kparams);
		if(!client.useMultiRequest)
			client.doQueue(callback);
	}

	public function getUrl(callback: Bool -> String -> Void, id: String, ?storageId: String, ?forceProxy: Bool = false):Void
	{
		var kparams = new StringMap<String>();
		RequestTools.addParam(kparams, "id", Native(id));
		RequestTools.addParam(kparams, "storageId", Native(storageId));
		RequestTools.addParam(kparams, "forceProxy", Native(Std.string(forceProxy)));
		client.queueServiceActionCall("flavorasset", "getUrl", kparams);
		if (!client.useMultiRequest)
			client.doQueue(callback);
	}
}