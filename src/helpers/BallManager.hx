package helpers;
import gameObjects.Ball;
import states.GameState;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.addons.nape.FlxNapeSprite;
import states.MatchState;
/**
 * ...
 * @author ...
 */
class BallManager 
{

	
	public var ball:Ball;
	var positions:Array<Float>;
	var match:MatchState;
	
	public function new(pos:Array<Float>, g:MatchState) 
	{
		positions = pos;
		match = g;
	}
	
	public function removeAll(){
		
	}
	
	public function start(){
		ball = new Ball();
		ball.x = positions[0]+match.myPlayer.getHeadOffset();
		ball.y = 100;
		ball.acceleration.y = System.GRAVITY;
		ball.from = 0;
		match.add(ball);
	}
	
	public function handleBall(aBall:FlxObject):Void 
	{
		var ball = cast(aBall, Ball);
		trace('inside');
		ball.velocity.y = -200;
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
		match.updateOpponentPosition(ball.to);
	}
	
	function sendBallToPosition(aBall:Ball, currentPosition:Int, nextPosition:Int) 
	{
		var ballOffset = 0;
		if (nextPosition < 3) {
			ball.velocity.x = -System.SPEED_X;
		} else {
			ball.velocity.x = System.SPEED_X;
			ballOffset = 20;
		}
		trace('sendBallToPosition nextPosition: ' + nextPosition);
		var currentPoint = positions[currentPosition];
		var nextPoint = positions[nextPosition] - ballOffset;
		
		var a = Tools.BallisticVel(new FlxPoint(nextPoint, match.PLAYER_Y_POS-ball.health), 55, ball);
		trace('ballistic: ' + a);
		
		ball.velocity.y = -Math.abs(a.y);
		ball.velocity.x = a.x;
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