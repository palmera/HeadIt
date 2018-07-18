package gameObjects;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSprite;
import flixel.FlxG;
import helpers.Tools;
/**
 * ...
 * @author Alejandro Grunwaldt
 */
class Ball extends FlxSprite
{
	public var towardsEnemy = false;
	public var from = -1;
	public var to = -1;
	public function new() 
	{
		super();
		Tools.setSpriteWithSize(this, "img/balls/Normal.png", FlxG.height * 0.12, FlxG.height * 0.12);

	}
	
}