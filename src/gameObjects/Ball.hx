package gameObjects;
import haxe.Timer;
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
	public var initialPosition = -1;
	public var finalPosition = -1;
	public var isColliding = false;
	public var count = 0;
	var interval:Float = 0.01;
	var maxTime:Float;
	public var totalTime:Float;
	var initialTime:Date;
	var finalTime:Date;
	var hasFallen:Bool;
	var timer:Timer;
	
	

	public function new(type:String, x:Float,y:Float,g:InteractionGroup) 
	{
		super(x, y, "img/balls/" + type);
		this.createCircularBody(30);
		this.body.group = g;
		this.timer = new Timer(10);
	}
	
	public function updateTimer(){
		maxTime = totalTime;
		this.timer.run = function(){
			this.substractTime();
		}
		
	}
	
	private function substractTime(){
		this.totalTime-= interval;
	}
	
	public function stopTimer(){
		this.timer.stop();
	}
}