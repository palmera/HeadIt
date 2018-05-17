package helpers;
import flixel.FlxG;
import flixel.FlxSprite;
import openfl.Assets;
import openfl.geom.Point;

 class Tools 
{
	 public static function getSpriteWithSize(path:String, width:Float, height:Float):FlxSprite{
		var image = new FlxSprite();
		image.loadGraphic(Assets.getBitmapData(path));
		var widthScale = width / image.width;
		var heightScale = height / image.height;
		image.scale.set(widthScale, heightScale);
		//image.origin.set(0, 0);
		image.updateHitbox();

		return image;
	}
	
	public static function setSpriteWithSize(originalSprite:FlxSprite, path:String, width:Float, height:Float):Void{
		originalSprite.loadGraphic(Assets.getBitmapData(path));
		var widthScale = width / originalSprite.width;
		var heightScale = height / originalSprite.height;
		originalSprite.scale.set(widthScale, heightScale);
		originalSprite.updateHitbox();
	}
	
	public static function calculateYSpeed(x1:Float, x2:Float):Float{
		var dx = Math.abs(x1 - x2);
		var dt = dx / System.SPEED_X;
		
		var vy = (System.GRAVITY * dt) / 2;
		trace('vy: ' + vy);
		return vy;
	}
	
	public static function toRadians(degrees:Float):Float {
		return (Math.PI * degrees) / 180;
	}
	
	
	static public function normalize(p0:Point) 
	{
		var m = 1/Math.sqrt(p0.x*p0.x + p0.y*p0.y);
        return { x:p0.x*m, y:p0.y*m};
	}
	
}