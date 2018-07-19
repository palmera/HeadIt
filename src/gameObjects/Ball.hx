package gameObjects;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSprite;
import flixel.FlxG;
import helpers.Tools;
/**
 * ...
 * @author Alejandro Grunwaldt
 */
class Ball extends FlxNapeSprite
{
	public var towardsEnemy = false;
	public var from = -1;
	public var to = -1;
	

	public function new(type:String, x:Float,y:Float) 
	{
		super(x,y,"img/balls/" + type);
		this.createCircularBody(30);
	}
	
}