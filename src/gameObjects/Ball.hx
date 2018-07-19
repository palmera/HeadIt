package gameObjects;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSprite;
import flixel.FlxG;
import helpers.Tools;
import nape.dynamics.InteractionFilter;
import nape.dynamics.InteractionGroup;
/**
 * ...
 * @author Alejandro Grunwaldt
 */
class Ball extends FlxNapeSprite
{
	public var towardsEnemy = false;
	public var from = -1;
	public var to = -1;
	

	public function new(type:String, x:Float,y:Float,g:InteractionGroup) 
	{
		super(x,y,"img/balls/" + type);
		this.createCircularBody(30);
		this.body.group = g;		
	}
	
}