package states;
import flash.geom.Point;
import flash.utils.Timer;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMatrix;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.ui.FlxButton;
import gameObjects.Ball;
import openfl.Assets;
import helpers.Tools;
import gameObjects.Team;
import flixel.FlxObject; 
import helpers.SoundManager;


/**
 * 
 * ...
 * @author 
 */
class GameState extends FlxState
{
	var myPlayer:Team;
	var opponent:Team;
	
	var positions:Array<Float>;
	
	var timerCounter:Float = 0;
	var maxTimerCounter:Float = 1;
	var hasStarted:Bool;
	
	var ball:Ball;
	var collided:Bool = false;
	inline static var SPEED_X:Float = 200;
	
	//private var disabledCollision:Bool;
	private var playerOpenForCollision:Bool;
	private var opponentOpenForCollision:Bool;

	override function create():Void
	{
		super.create();
		var btn_back = new FlxButton(20, 20, "Back", back);
		add(btn_back);
	}
	
	public function new(team1:Team,team2:Team) 
	{
		super();
		myPlayer = team1;
		myPlayer.isEnemy = false;
		opponent = team2;
		opponent.isEnemy = true;
		loadVariables();
		loadAssets();
		loadTeams();
		hasStarted = false;
		ball = new Ball();
	}
	
	private function loadVariables(){
		positions = [];
		var offset = (FlxG.width / 6 - myPlayer.getWidth()) / 2;
		for (i in 0...6){
			var pos = offset + i * FlxG.width / 6;
			trace('pos ' + i + ': ' + pos);
			positions.push(pos);
		}
		
	}
	
	private function loadAssets(){
		var background:FlxSprite;
		background = Tools.getSpriteWithSize("img/Stadium.png",FlxG.width,FlxG.height);
		background.x = 0;
		background.y = 0;
		add(background);

		
	}
	
	private function loadTeams(){		
		myPlayer.Flip();
		myPlayer.x = positions[0];
		myPlayer.y = 170;
		add(myPlayer);
		
		opponent.x = positions[5];
		opponent.y = 170;
		add(opponent);
	}
	
	private function startGame(){
		var testTimer = new haxe.Timer(100);
		testTimer.run = function ()
		{
			trace('test timer');
			testTimer.stop();
		};
		FlxG.debugger.visible = true;
		FlxG.debugger.drawDebug = true;
		hasStarted = true;
		Tools.setSpriteWithSize(ball, "img/balls/Normal.png", FlxG.height * 0.12, FlxG.height * 0.12);
		ball.x = positions[myPlayer.getCurrentPosition()]+myPlayer.getHeadOffset();
		ball.y = 100;
		ball.acceleration.y = System.GRAVITY;
		ball.from = 0;
		add(ball);
		//disabledCollision = false;
		playerOpenForCollision = true;
		opponentOpenForCollision = true;
	}
	
	function playerBallCollision(aPlayer:FlxObject, aBall:FlxObject):Void
	{
		var ball = cast(aBall, Ball);
		
		var collidedWithPlayer = ball.x < FlxG.width / 2;
		var collidedWithOpponent = ball.x > FlxG.width / 2;
		
		if (collidedWithPlayer) {
			SoundManager.Instance().playHeadBall();
			if (playerOpenForCollision) {
				trace('entra a player colission');
				handleBall(aBall);
				playerOpenForCollision = false;
			} else {
				var playerTimer = new haxe.Timer(400);
				playerTimer.run = function() { 
					playerOpenForCollision = true;
					trace('player timer');
					playerTimer.stop();
				}
			}
			
		} 
		
		if (collidedWithOpponent) {
			if (opponentOpenForCollision) {			
				trace('entra a opponent colission');
				handleBall(aBall);
				opponentOpenForCollision = false;	
			} else {
				var opponentTimer = new haxe.Timer(400);
				opponentTimer.run = function() { 
					opponentOpenForCollision = true;
					trace('opponent timer');
					opponentTimer.stop();
				}
			}
		}
		
		
		
	}
	
	function sendBallToPosition(currentPosition:Int, nextPosition:Int) 
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
		
		var a = Tools.BallisticVel(new FlxPoint(nextPoint, 170-ball.health), 60, ball);
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
	
	override public function update(elapsed:Float):Void
	{
		timerCounter += elapsed;
		if (timerCounter > maxTimerCounter && !hasStarted){
			startGame();
			timerCounter = 0;
		}
		if (hasStarted){
			FlxG.overlap(myPlayer.head, ball, playerBallCollision);
			FlxG.overlap(opponent.head, ball, playerBallCollision);
		}
		
   		if (FlxG.keys.justPressed.LEFT)
		{
			myPlayer.moveLeft();
			myPlayer.x = positions[myPlayer.getCurrentPosition()];
		}
		
		if (FlxG.keys.justPressed.RIGHT)
		{
			myPlayer.moveRight();
			myPlayer.x = positions[myPlayer.getCurrentPosition()];
		}
		super.update(elapsed);
	}
	
	function updateOpponentPosition(nextPosition:Int) 
	{
		if (nextPosition >= 3){
			trace('opponent nueva pos: ' + nextPosition);
			trace('opponent nueva positions: ' + positions[nextPosition]);
			opponent.x = positions[nextPosition];
		}
	}
	private function back():Void
	{
		trace("vuelta");
		FlxG.switchState(new SelectTeamState());
	}
	
	function handleBall(aBall:FlxObject):Void 
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
		sendBallToPosition(ball.from, ball.to);
		updateOpponentPosition(ball.to);
	}
}