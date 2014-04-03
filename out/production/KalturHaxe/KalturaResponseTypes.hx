package kalturhaxe;

typedef FlavorAssetResponse = {
	var flavorParamsId : String;
	var width: String;
	var height: String;
	var bitrate: String;
	var frameRate: String;
	var isOriginal: String;
	var isWeb: String;
	var containerFormat: String;
	var videoCodecId: String;
	var status: String;
	var id: String;
	var entryId: String;
	var partnerId: String;
	var version: String;
	var size: String;
	var tags: String;
	var fileExt: String;
	var createdAt: String;
	var updatedAt: String;
	var deletedAt: String;
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