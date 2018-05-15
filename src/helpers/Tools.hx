package helpers;
import flixel.FlxG;
import flixel.FlxSprite;
import openfl.Assets;

/**
 * ...
 * @author 
 */
 class Tools 
{

	 public static function getSpriteWithSize(path:String,width:Float,height:Float ):FlxSprite{
		var image = new FlxSprite();
		image.loadGraphic(Assets.getBitmapData(path));
		var widthScale = width / image.width;
		var heightScale = height / image.height;
		image.scale.set(widthScale, heightScale);
		//image.origin.set(0, 0);
				image.updateHitbox();

		return image;
	}
	
	
}