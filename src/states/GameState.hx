package states;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import gameObjects.Ball;
import openfl.Assets;
import helpers.Tools;
import gameObjects.Team;
import flixel.FlxObject; 


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

	override function create():Void
	{
		super.create();
		var btn_back = new FlxButton(20, 20, "Back", back);
		add(btn_back);
	}
	//var balls:[FlxSprite];
	public function new(team1:Team,team2:Team) 
	{
		super();
		myPlayer = team1;
		opponent = team2;
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
		FlxG.debugger.visible = true;
		FlxG.debugger.drawDebug = true;
		hasStarted = true;
		Tools.setSpriteWithSize(ball, "img/balls/Normal.png", FlxG.height * 0.12, FlxG.height * 0.12);
		ball.x = positions[myPlayer.getCurrentPosition()]+myPlayer.getHeadOffset();
		ball.y = 100;
		ball.acceleration.y = System.GRAVITY;
		ball.from = 0;
		add(ball);
		disabledCollision = false;
	}
	private var disabledCollision:Bool;
	function playerBallCollision(aHead:FlxObject, aBall:FlxObject):Void
	{
		trace('outside');
		if (!disabledCollision) 
		{
			trace('inside');
			aBall.velocity.y = -200;
			var nextPosition = calculateNextPosition(aBall);
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
			disabledCollision = true;
		} else {
			var timer = new haxe.Timer(200); // 1000ms delay
			timer.run = function() { 
				trace('inside timer');
				disabledCollision = false;
				timer.stop();
			}
			
		}
		
		
		
	}
	
	function sendBallToPosition(currentPosition:Int, nextPosition:Int) 
	{
		if (nextPosition < 3) {
			ball.velocity.x = -System.SPEED_X;
		} else {
			ball.velocity.x = System.SPEED_X;
		}
		var currentPoint = positions[currentPosition];
		var nextPoint = positions[nextPosition];
		var vy = Tools.calculateYSpeed(currentPoint, nextPoint);
		ball.velocity.y = -vy;
	}
	
	function calculateNextPosition(aBall:FlxObject):Int 
	{
		var ball = cast(aBall, Ball);
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
		if(hasStarted){
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
		trace('opponent nueva pos: ' + nextPosition);
		trace('opponent nueva positions: ' + positions[nextPosition]);
		if(nextPosition >= 3){
			opponent.x = positions[nextPosition];
		}
	}
	private function back():Void
	{
		trace("vuelta");
		FlxG.switchState(new SelectTeamState());
	}
}