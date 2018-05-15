package states;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
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
	
	var ball:FlxSprite;
	var collided:Bool = false;

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
		ball = Tools.getSpriteWithSize("img/balls/Normal.png", FlxG.height * 0.12, FlxG.height * 0.12);
		ball.x = positions[myPlayer.getCurrentPosition()]+myPlayer.getHeadOffset();
		ball.y = 100;
		ball.acceleration.y = 600;
		//ball.updateHitbox();
		add(ball);
	}
	
	function playerBallCollision(aHead:FlxObject, aBall:FlxObject):Void
	{
		trace("playerBall");
		aBall.velocity.y = -200;
	}
	override public function update(elapsed:Float):Void
	{
		
		timerCounter += elapsed;
		if (timerCounter > maxTimerCounter && !hasStarted){
			startGame();
			timerCounter = 0;
		}
		FlxG.overlap(myPlayer.head, ball, playerBallCollision);
		if(hasStarted){
			FlxG.overlap(myPlayer.head, ball, playerBallCollision);
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
	
}