package helpers;
import flixel.group.FlxGroup;
import gameObjects.Ball;
import states.GameState;
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
	
	public function new(pos:Array<Float>, g:MatchState) 
	{
		super();
		group = new InteractionGroup(true);
		positions = pos;
		match = g;
		balls = new Array<Ball>();
		opponentBalls = new Array<Ball>();
		start();
	}
	
	public function removeAll(){
		
	}
	
	public function addBall(){
		trace("add ball");

		var newBall = new Ball(Balls.NORMAL, FlxG.width * 1.1, FlxG.height * 0.5,group);
		newBall.body.velocity.x = FlxG.width*-45/56;
		newBall.body.velocity.y = FlxG.height * 2;
		this.add(newBall);
		balls.push(newBall);
		addBallTime = Date.now();

	}
	
	public function start(){
		
		addBall();
		newBallTimer = new haxe.Timer(8000);
		newBallTimer.run = function ()
		{
			addBall();
		};
		
	}
	
	public function handleBall(aBall:FlxObject):Void 
	{
		var ball = cast(aBall, Ball);
		trace('inside');
		/*ball.velocity.y = -200;
		var nextPosition = calculateNextPosition(ball);
		trace('nextPosition: ' + nextPosition);
		if(ball.to == -1){
			ball.to = nextPosition;
		} else {
			ball.from = ball.to;
			ball.to = nextPosition;
		}
		trace('ball from: ' + ball.from);
		trace('ball to: ' + ball.to);
		sendBallToPosition(ball,ball.from, ball.to);
		match.updateOpponentPosition(ball.to);*/
	}
	
	function sendBallToPosition(aBall:Ball, currentPosition:Int, nextPosition:Int) 
	{
		var ballOffset = 0;
		if (nextPosition < 3) {
			aBall.velocity.x = -System.SPEED_X;
		} else {
			aBall.velocity.x = System.SPEED_X;
			ballOffset = 20;
		}
		trace('sendBallToPosition nextPosition: ' + nextPosition);
		var currentPoint = positions[currentPosition];
		var nextPoint = positions[nextPosition] - ballOffset;
		
		var a = Tools.BallisticVel(new FlxPoint(nextPoint, match.PLAYER_Y_POS-aBall.health), 55, aBall);
		trace('ballistic: ' + a);
		
		aBall.velocity.y = -Math.abs(a.y);
		aBall.velocity.x = a.x;
	}

	
	function calculateNextPosition(ball:Ball):Int 
	{
		// var ball = cast(aBall, Ball);
		var nextPosition = -1;
		if (ball.towardsEnemy){
			nextPosition = FlxG.random.int(0, 2);
		} else {
			nextPosition = FlxG.random.int(3, 5);
		}
		ball.towardsEnemy = !ball.towardsEnemy;
		return nextPosition;
	}
}