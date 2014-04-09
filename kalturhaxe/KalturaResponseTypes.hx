package kalturhaxe;

typedef FlavorAssetResponse = {
	var flavorParamsId : Int;
	var width: Int;
	var height: Int;
	var bitrate: Int;
	var frameRate: Int;
	var isOriginal: Bool;
	var isWeb: Bool;
	var containerFormat: String;
	var videoCodecId: String;
	var status: Int;
	var id: String;
	var entryId: String;
	var partnerId: Int;
	var version: String;
	var size: Int;
	var tags: String;
	var fileExt: String;
	var createdAt: Int;
	var updatedAt: Int;
	var deletedAt: Int;
	var description: String;
	var partnerData: String;
	var partnerDescription: String;
	var actualSourceAssetParamsIds: String;
}

class KalturaResponseTypes{

	public static function createFlavorAssetResponse(response:Dynamic):FlavorAssetResponse
	{
		return cast response;
	}
}