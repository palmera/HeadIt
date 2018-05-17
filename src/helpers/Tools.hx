package helpers;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import gameObjects.Ball;
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
	
	public static function toRadians(degrees:Float):Float {
		return (Math.PI * degrees) / 180;
	}
	
	public static function BallisticVel(target:FlxPoint, angle:Float, ball:Ball):FlxVector{
		trace('target: ' + target);
		trace('angle: ' + angle);
		trace('ball: ' + ball);
		var dir = target.subtractPoint(ball.getPosition());
		trace('dir: ' + dir);
		var h = dir.y;  // get height difference
		dir.y = 0;  // retain only the horizontal direction
		
		
		var dist = dir.x;  // get horizontal distance
		trace('dist: ' + dist);
		
		var a = Tools.toRadians(angle);  // convert angle to radians
		dir.y = dist * Math.tan(a);  // set dir to the elevation angle
		dist += h / Math.tan(a);  // correct for small height differences
		// calculate the velocity magnitude
		var vel;
		var l = dist * System.GRAVITY / Math.sin(2 * a);
		if (l < 0) l = -l;
		trace('l: ' + l);
		vel = Math.sqrt(l);
		trace('vel: ' + vel);
		var ret = dir.toVector().normalize().scale(vel);
		trace('ret: ' + ret);
		return ret;
	}
	
}