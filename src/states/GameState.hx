package states;
import flash.geom.Point;
import flash.utils.Timer;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSprite;
import flixel.math.FlxMatrix;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.ui.FlxButton;
import gameObjects.Ball;
import helpers.BallManager;
import openfl.Assets;
import helpers.Tools;
import gameObjects.Team;
import flixel.FlxObject; 
import helpers.SoundManager;
import flixel.addons.nape.FlxNapeSpace;
import flixel.addons.nape.FlxNapeSprite;


/**
 * 
 * ...
 * @author 
 */
class GameState extends FlxState
{
	public var myPlayer:Team;
	var opponent:Team;
	
	var positions:Array<Float>;
	
	var timerCounter:Float = 0;
	var maxTimerCounter:Float = 1;
	var hasStarted:Bool;
	
	var ballManager:BallManager;
	//var ball:Ball;
	var collided:Bool = false;
	inline static var SPEED_X:Float = 200;
	public var PLAYER_Y_POS:Float = 6 * (FlxG.height / 11);
	
	//private var disabledCollision:Bool;
	private var playerOpenForCollision:Bool;
	private var opponentOpenForCollision:Bool;
	
	
	var pruebaPelota:FlxNapeSprite;
	var ground:Float;

	override function create():Void
	{
		super.create();
		
		
		
		startPrueba();
		
		var btn_back = new FlxButton(20, 20, "Back", back);
		add(btn_back);
	}
	
	function startPrueba(){
		FlxNapeSpace.init();
		ground = FlxG.height - 30;
		FlxNapeSpace.createWalls(0, 0, FlxG.width, ground);
		
		var newBall = new FlxNapeSprite(FlxG.width / 2,0, "img/balls/Normal.png");
		newBall.body.userData.flxSprite = newBall;
		add(newBall);
		if (FlxNapeSpace.space.gravity.y != 500)
			FlxNapeSpace.space.gravity.setxy(0, 500);
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
		loadPosts();
		hasStarted = false;
		ballManager = new BallManager(positions, this);
	}
	
	private function startBalls(){
		ballManager.removeAll();
		ballManager.start();
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
	
	private function loadPosts()
	{
		var playerFrontGoalPosts:FlxSprite;
		var enemyFrontGoalPosts:FlxSprite;
		
		playerFrontGoalPosts = Tools.getSpriteWithSize("img/GoalFront-hd.png", 180, 263);
		playerFrontGoalPosts.y = 228;
		playerFrontGoalPosts.x = -38;
		add(playerFrontGoalPosts);
		
		enemyFrontGoalPosts = Tools.getSpriteWithSize("img/GoalFront-hd.png", -FlxG.width, FlxG.height);
		add(enemyFrontGoalPosts);
	}
	
	private function loadTeams(){		
		myPlayer.Flip();
		myPlayer.x = positions[0];
		myPlayer.y = PLAYER_Y_POS;
		add(myPlayer);
		
		opponent.x = positions[5];
		opponent.y = PLAYER_Y_POS;
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
		startBalls();
		
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
				ballManager.handleBall(aBall);
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
				ballManager.handleBall(aBall);
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
	
	
	
	override public function update(elapsed:Float):Void
	{
		timerCounter += elapsed;
		if (timerCounter > maxTimerCounter && !hasStarted){
			startGame();
			timerCounter = 0;
		}
		if (hasStarted){
			
			FlxG.overlap(myPlayer.head, ballManager.ball, playerBallCollision);
			FlxG.overlap(opponent.head, ballManager.ball, playerBallCollision);
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
	
	public function updateOpponentPosition(nextPosition:Int) 
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
		remove(myPlayer);
		myPlayer = null;
		FlxG.switchState(new SelectTeamState());
	}
	
	
}