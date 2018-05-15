package gameObjects;
import flixel.FlxSprite;

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
	}
	
}