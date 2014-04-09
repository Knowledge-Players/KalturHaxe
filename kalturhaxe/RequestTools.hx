package kalturhaxe;

import haxe.Http;
import haxe.ds.StringMap;

enum ParamValue {
	Native(s: String);
	Object(m: StringMap<String>);
}

class RequestTools{

	public static function addParam(paramObject:StringMap<String>, paramName:String, paramValue:ParamValue):Void
	{
		if (paramValue == null)
			return;

		switch(paramValue){
			case Native(s): paramObject.set(paramName, s);

			case Object(m):
				for(subName in m.keys()){
					addParam(paramObject, paramName + ":" + subName, Native(m.get(subName)));
				}
		}
	}

	public static function executeRequest(callback: Bool -> String -> Void, url: String, params: StringMap<String>, files: StringMap<String>):Void
	{
		var target = url + '&' + buildQuery(params);
		var http = new Http(target);
		http.onData = function(data){
			callback(true, data);
		}

		http.onError = function(msg){
			callback(false, msg);
		}

		http.request(true);
	}

	static function buildQuery(formdata: StringMap<String>, ?numeric_prefix: Int, ?arg_separator: String = "&") {
		var tmp = new Array<String>();
		var _http_build_query_helper = function (key: String, val: String, arg_separator: String): String {
			var k, tmp = [];
			var value: String;

			if (val == "true")
				value = "1";
			else
				value = "0";


			return key + "=" + StringTools.urlEncode(val);

			/*if (val != null && typeof(val) == "object") {
				for (k in val) {
					if (val[k] != null) {
						tmp.push(_http_build_query_helper(key + "[" + k + "]", val[k], arg_separator));
					}
				}
				return tmp.join(arg_separator);
			} else
			if (typeof(val) != "function") {

			} else {
				//throw new Error('There was an error processing for http_build_query().');
				return '';
			}*/
		};

		for (key in formdata.keys()) {
			var value = formdata.get(key);
			/*if (numeric_prefix && !isNaN(key)) {
				key = String(numeric_prefix) + key;
			}*/
			tmp.push(_http_build_query_helper(key, value, arg_separator));
		}
		return tmp.join(arg_separator);
	}
}