KalturHaxe
==========

Kaltura API for Haxe

Usage
=====
To get access to the API, you have to create a KalturHaxe object
```haxe
var app = new KalturaHaxe(partnerId, serviceUrl);
```
Then you need to start a session
```haxe
app.createConnection(secret, callback);
```
where secret is your secret string from your Kaltura user and callback is a Bool -> String -> Void function that will be called on complete. The Boolean is whether or not your request succeeded, and the content of the response will be in the String parameter. For this example, it will be your KS. Note that the KS has been automatically stored for futur API calls.

Then you can call some wrappers we made, like getting the URL for your asset with the correct bitrate for your connection:
```haxe
app.getBitrateWiseAsset(entryId, bitrate, callback);
```
where entryId is your asset identifier, bitrate the maximum bitrate you want and callback a Bool -> String -> Void function where the URL is stored in the String argument.