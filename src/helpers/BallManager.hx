package helpers;
import flixel.group.FlxGroup;
import gameObjects.Ball;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.addons.nape.FlxNapeSprite;
import states.MatchState;
import haxe.Timer;
import nape.dynamics.InteractionGroup;
import Date;
/**
 * ...
 * @author ...
 */
class BallManager extends FlxGroup
{

	
	public var balls:Array<Ball>;
	public var opponentBalls:Array<Ball>;
	var positions:Array<Float>;
	var match:MatchState;
	var newBallTimer:Timer;
	var group:InteractionGroup;
	var addBallTime:Date;
	var type:String;
	
	public function new(pos:Array<Float>, g:MatchState, type:String) 
	{
		super();
		this.type = type;
		group = new InteractionGroup(true);
		positions = pos;
		match = g;
		balls = new Array<Ball>();
		opponentBalls = new Array<Ball>();
		start();
	}

	
	public function addBall(){
		trace("add ball");

		var newBall = new Ball(this.type, FlxG.width * 1.1, FlxG.height * 0.5,group);
		newBall.body.velocity.x = FlxG.width*-45/56;
		newBall.body.velocity.y = FlxG.height * 2;
		this.add(newBall);
		balls.push(newBall);
		addBallTime = Date.now();

	}
	
	public function stop(){
		newBallTimer.stop();
	}
	
	public function start(){
		
		addBall();
		newBallTimer = new haxe.Timer(8000);
		newBallTimer.run = function ()
		{
			addBall();
		};
		
	}
	

}