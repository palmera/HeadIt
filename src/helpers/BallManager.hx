package helpers;
import gameObjects.Ball;
import states.GameState;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.addons.nape.FlxNapeSprite;
import states.MatchState;
import haxe.Timer;
/**
 * ...
 * @author ...
 */
class BallManager 
{

	
	public var balls:Array<Ball>;
	var positions:Array<Float>;
	var match:MatchState;
	var newBallTimer:Timer;
	public function new(pos:Array<Float>, g:MatchState) 
	{
		positions = pos;
		match = g;
		balls = new Array<Ball>();
		start();
	}
	
	public function removeAll(){
		
	}
	
	public function addBall(){
		trace("add ball");
		//var newBall = new Ball(Balls.NORMAL, FlxG.width * 1.1, FlxG.height * 0.4);
		//newBall.velocity.x = -System.SPEED_X;
		//newBall.velocity.y = FlxG.height * 52 / 32;
		//newBall.x = positions[0]+match.myPlayer.getHeadOffset();
		//newBall.y = 0;
		var newBall = new Ball(Balls.NORMAL, FlxG.width * 1.1, FlxG.height * 0.4);
		newBall.body.velocity.x = -System.SPEED_X;
		newBall.body.velocity.y = FlxG.height * 52 / 32;
		this.match.add(newBall);
		balls.push(newBall);

		//var newBall = new 
	/*
	 * Ball* ballToAdd = [Ball createWithName:ballName];
    ballToAdd.position=ccp(1.1f*screenWidth,0.4f*screenHeight);
    ballToAdd.physicsBody.velocity=ccp((-450.0f/568.0f)*screenWidth,(520.0f/320.0f)*screenHeight);
    [self.physicsWorld addChild:ballToAdd z:2];
    [allBalls addObject:ballToAdd];
    addBallTime=[NSDate date];
    // ballToAdd.scale=0.8;
	
	

		
		add(newBall);
	 * */	
	}
	
	public function start(){
		
		addBall();
		newBallTimer = new haxe.Timer(8000);
		newBallTimer.run = function ()
		{
			addBall();
		};
		/*ball = new Ball();
		ball.x = positions[0]+match.myPlayer.getHeadOffset();
		ball.y = 100;
		ball.acceleration.y = System.GRAVITY;
		ball.from = 0;
		match.add(ball);*/
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