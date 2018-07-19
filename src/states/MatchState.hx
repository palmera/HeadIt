package states;
import flixel.FlxState;
import flixel.text.FlxText;
import gameObjects.Ball;
import gameObjects.Country;
import gameObjects.Team;
import flixel.FlxG;
import flixel.math.FlxPoint;
import haxe.Timer;
import helpers.Tools;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSpace;
import helpers.BallManager;
import helpers.Balls;
import flixel.addons.nape.FlxNapeSprite;
import nape.phys.BodyType;
import nape.dynamics.InteractionFilter;
import nape.phys.Body;
import nape.shape.Polygon;
import flixel.FlxObject;
import helpers.PlayMode;
import gameObjects.Tournament;
import Random;
import helpers.TournamentStages;
//import helpers.PlayMode;
/**
 * ...
 * @author 
 */
class MatchState extends FlxState
{
	public var myPlayer:Team;
	var opponent:Team;
	var country1:Country;
	var country2:Country;
	
	var screenWidth:Float;
	var screenHeight:Float;
	
	var matchEndScore = 3;
	var myScore:Int;
	var opponentScore:Int;
	var positions:Array<Float>;
	var movingAmount:Float;
	
	var startingPointLeft:FlxPoint;
	var startingPointRight:FlxPoint;
	var scoreLabel:FlxText;
	var gameMode:Int;
	
	var floor:FlxSprite;
	var leftLimit:FlxSprite;
	var rightLimit:FlxSprite;
	var ballManager:BallManager;
	
	var level:Int;
	var tournament:Tournament;
	var minTime:Float;
	
	var time0:Float;
	var time1:Float;
	var time2:Float;
	var time3:Float;
	var time4:Float;

	
	public var isUpdatingScore = false;
	public var PLAYER_Y_POS:Float = 255;
	var practiceCount = 0;
	
	
	public function new(country1:Country, country2:Country , mode:Int, ?t:Tournament = null) 
	{
		super();
		this.country1 = country1;
		this.country2 = country2;
		gameMode = mode;
		myPlayer = country1.getTeam();
		opponent = country2.getTeam();
		tournament = t;
		if(mode == PlayMode.TOURNAMENT){
			level = tournament.getTournamentState();
		}
		else level = 1;
	}
	
	
	override public function create():Void{
		setVariables();
		setAssets();
		
		setScoreLabel();
		
		loadTeams();
		
		initPhysics();

		setBalls();
		loadPosts();
		loadEfficiency();
		loadTimes();
	}
	
	private function setVariables(){
		screenHeight = FlxG.height;
		screenWidth = FlxG.width;
		myScore = 0;
		opponentScore = 0;
		loadPoints();
	}
	
	private function loadPoints(){
		positions = [];
		movingAmount = screenWidth / 6;
		var offset = (screenWidth / 6 - myPlayer.getWidth()) / 2;
		for (i in 0...6){
			var pos = offset + i * movingAmount;
			positions.push(pos);
		}
		startingPointLeft = new FlxPoint(screenWidth *-0.1, screenHeight * 0.4);
		startingPointRight = new FlxPoint(screenWidth* 1.1, screenHeight * 0.4);
	}
	private function setAssets(){
		var background:FlxSprite;
		background = Tools.getSpriteWithSize("img/Stadium.png",FlxG.width,FlxG.height);
		background.x = 0;
		background.y = 0;
		add(background);
		
	}
	private function initPhysics(){
		FlxNapeSpace.init();
		var ground = FlxG.height - 10;
		FlxNapeSpace.createWalls(0, ground - 10, FlxG.width, ground);
		FlxNapeSpace.createWalls(-10, 0, -9, ground);
		FlxNapeSpace.createWalls(FlxG.width+10, 2*ground/3, FlxG.width+11, ground);
		
		
		if (FlxNapeSpace.space.gravity.y != 800)
			FlxNapeSpace.space.gravity.setxy(0, 800);
			
		FlxNapeSpace.drawDebug = true;
		
		floor = Tools.getSpriteWithSize("img/players/UruguayHead.png", FlxG.width, 10);
		floor.x = 0;
		floor.y = ground-20;
		floor.set_visible(false);
		this.add(floor);
		
		leftLimit = Tools.getSpriteWithSize("img/players/UruguayHead.png", 1, FlxG.height/3);
		leftLimit.x = 0;
		leftLimit.y = 2*FlxG.height/3;
		leftLimit.set_visible(false);
		this.add(leftLimit);
		
		rightLimit = Tools.getSpriteWithSize("img/players/UruguayHead.png", 1, FlxG.height/3);
		rightLimit.x = FlxG.width;
		rightLimit.y = 2*FlxG.height/3;
		rightLimit.set_visible(false);
		this.add(rightLimit);
	}
	
	
	
	
	
	private function loadPosts()
	{
		var playerFrontGoalPosts:FlxSprite;
		var enemyFrontGoalPosts:FlxSprite;
		
		playerFrontGoalPosts = Tools.getSpriteWithSize("img/GoalFront-hd.png", 180, 263);
		playerFrontGoalPosts.y = 228;
		playerFrontGoalPosts.x = -38;
		add(playerFrontGoalPosts);
		
		enemyFrontGoalPosts = Tools.getSpriteWithSize("img/GoalFront-hd.png", -180, 263);
		enemyFrontGoalPosts.y = 228;
		enemyFrontGoalPosts.x = 762;
		add(enemyFrontGoalPosts);
	}
	
	
	
	private function setBalls(){
		ballManager = new BallManager(positions, this);
		add(ballManager);
	}
	
	private function setScoreLabel(){
		if(gameMode == PlayMode.PRACTICE){
			scoreLabel = new FlxText(screenWidth / 2, screenHeight * 0.05, 0, "" + practiceCount, 16);
		}
		else{
			scoreLabel = new FlxText(0, screenHeight * 0.05,screenWidth,myPlayer.get_name()+" "+myScore+" - "+opponentScore+" "+opponent.get_name());
		}
		scoreLabel.setFormat("fonts/Supersonic-Rocketship.ttf", 40);
		scoreLabel.alignment = "center";
		add(scoreLabel);
	}
	
	private function loadTeams(){	
		myPlayer.position = 0;
		opponent.position = 5;
		myPlayer.Flip();
		myPlayer.x = positions[0];
		myPlayer.y = PLAYER_Y_POS;
		
		add(myPlayer);
		
		opponent.x = positions[5];
		opponent.y = PLAYER_Y_POS;
		add(opponent);
		opponent.setPositions(positions);
		myPlayer.setPositions(positions);
		
		
	}
	
	
	private function loadTimes(){
		time0 = 1;
		time1 = 1.1;
		time2 = 1.35;
		time3 = 1.45;
		time4 = 1.5;
	}
	
	private function loadEfficiency(){
		if(gameMode == PlayMode.PRACTICE){
			minTime = -1;
		}
		else{
			switch(level){
				case 1:
					minTime = 0.7;				
				case 2:{
					minTime = 0.5;
				}
				case 3:{
					minTime = 0.3;
				}
				default:{
					minTime = 0.7;
				}
			}
		}
	}
	
	
	
	
	override public function update(elapsed:Float):Void
	{

		for(ball in ballManager.balls){
				FlxG.overlap(myPlayer.collisionHead, ball, playerBallCollision);
				FlxG.overlap(opponent.collisionHead, ball, playerBallCollision);
				FlxG.overlap(floor, ball, ballFloorCollision);
				FlxG.overlap(leftLimit, ball, ballFloorCollision);
				FlxG.overlap(rightLimit, ball, ballFloorCollision);
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
	
	function clearScreen(){
		ballManager.stop();
		for(i in 0...ballManager.balls.length){
					var chosenBall = ballManager.balls[i];
					ballManager.remove(chosenBall);
					chosenBall = null;
		}
		remove(ballManager);
		ballManager = null;
		remove(myPlayer) ;
		remove(opponent);
		myPlayer = null;
		opponent = null;
		country1 = null;
		country2 = null;
	}
	
	function updateScore(){
		ballManager.stop();
		isUpdatingScore = true;
		scoreLabel.text = "" + myPlayer.get_name() + " " + myScore+" - " + opponentScore+" " + opponent.get_name();
		if (myScore == matchEndScore){//gane
			var switchTimer = new Timer(2000);
			switchTimer.run = function(){
				switchTimer.stop();
				
				if (gameMode == PlayMode.QUICKGAME){
					clearScreen();
					FlxG.switchState(new SelectModeState());
				}
				else {
					if (this.tournament.getTournamentState() != TournamentStages.Final){
						this.tournament.setTournamentState(this.tournament.getTournamentState() +1);
						if (this.tournament.getTournamentState() == TournamentStages.SemiFinals){
							this.tournament.pushToSemifinalists(this.tournament.getPlayerCountry());
							clearScreen();
							FlxG.switchState(new TournamentState(this.tournament));
						}
						if (this.tournament.getTournamentState() == TournamentStages.Final){
							this.tournament.pushToFinalists(this.tournament.getPlayerCountry());
							clearScreen();
							FlxG.switchState(new TournamentState(this.tournament));
						}
					}else{
						this.tournament.setTournamentState(this.tournament.getTournamentState() +1);
						this.tournament.setChampion(tournament.getPlayerCountry());
						clearScreen();
						FlxG.switchState(new TournamentState(this.tournament));
					}
				}
			}
			
		}
		else if (opponentScore == matchEndScore){//perdi
			var switchTimer = new Timer(2000);
			switchTimer.run = function(){
				switchTimer.stop();
				
				if (gameMode == PlayMode.QUICKGAME){
					clearScreen();
					FlxG.switchState(new SelectModeState());
				}
				else {
					if (this.tournament.getTournamentState() == TournamentStages.RoundOfFour){
						tournament.pushToSemifinalists(this.country2);
						var semifinalistCountries = this.tournament.getSemifinalistCountries().copy();
						var c = Random.fromArray([semifinalistCountries[0], semifinalistCountries[1]]);
						tournament.simulateMatchesSemifinals();
						tournament.pushToFinalists(c);
						var finalistCountries = this.tournament.getFinalistCountries().copy();
						var c2 = Random.fromArray([finalistCountries[0], finalistCountries[1]]);
						this.tournament.setChampion(c2);
						this.tournament.setTournamentState(TournamentStages.EndedLoose);
						clearScreen();
						FlxG.switchState(new TournamentState(this.tournament));
					
					}
					else if (this.tournament.getTournamentState() == TournamentStages.SemiFinals){
						tournament.pushToFinalists(this.country2);
						var finalistCountries = this.tournament.getFinalistCountries().copy();
						var c2 = Random.fromArray([finalistCountries[0], finalistCountries[1]]);
						this.tournament.setChampion(c2);
						this.tournament.setTournamentState(TournamentStages.EndedLoose);
						clearScreen();
						FlxG.switchState(new TournamentState(this.tournament));
					}
					else{
						this.tournament.setChampion(this.country2);
						this.tournament.setTournamentState(TournamentStages.EndedLoose);
						clearScreen();
						FlxG.switchState(new TournamentState(this.tournament));
					}
				}
			}
			
		}
		else{
			var delay = new Timer(2000);
			delay.run = function(){
				delay.stop();
				isUpdatingScore = false;
				myPlayer.position = 0;
				opponent.position = 5;
				myPlayer.x = positions[0];
				opponent.x = positions[5];
				for(i in 0...ballManager.balls.length){
					var chosenBall = ballManager.balls[i];
					ballManager.remove(chosenBall);
				}
				ballManager.opponentBalls.splice(0, ballManager.opponentBalls.length);
				ballManager.balls.splice(0, ballManager.balls.length);
				ballManager.start();

			}
		}

	}
	
	function ballFloorCollision(aFloor:FlxObject, aBall:FlxObject):Void
	{
		var ball = cast(aBall, Ball);
		if (!isUpdatingScore){
			isUpdatingScore = true;
			if(ball.count % 2 == 0){
				if(gameMode == PlayMode.PRACTICE){
					//PERDISTE
					var switchTimer = new Timer(2000);
					switchTimer.run = function(){
						clearScreen();
						switchTimer.stop();
						FlxG.switchState(new SelectModeState());
					}
					
				}
				else{
					opponentScore++;
					this.updateScore();
				}
			}
			else{
				myScore++;
				this.updateScore();
			}
		}
		
	}
function playerBallCollision(aPlayer:FlxObject, aBall:FlxObject):Void
	{
		var ball = cast(aBall, Ball);
		
		var collidedWithPlayer = ball.x < FlxG.width / 2;
		var collidedWithOpponent = ball.x > FlxG.width / 2;
		
		if (!isUpdatingScore){
			if(!ball.isColliding){
				ball.isColliding = true;
				this.pushBall(ball);
				this.calculateNextBall();
				var ballTimer = new haxe.Timer(600);
				ballTimer.run = function() { 
					ball.isColliding = false;
					ballTimer.stop();
				}
			}
			
		}
		

	}
	
	private function calculateBallVelocity(aBall:Ball, to:FlxPoint, direction:Int, time:Float):FlxPoint{
		var initialPos = aBall.getPosition();
		var distanceX = to.x - initialPos.x;
		/*if (direction == 2)
			distanceX += 0.016 * screenWidth;
		else distanceX -= 0.016 * screenWidth;*/
		var distanceY = to.y - initialPos.y;
		var speedX = distanceX / time;
		var speedY = distanceY / time - (FlxNapeSpace.space.gravity.y*time)/2;
		return new FlxPoint(speedX, speedY);
	}
	
	private function pushBall(aBall:Ball)
	{
		var time:Float = 0;
		if (aBall.count % 2 == 0)
		{//cabecea mi jugador
			if(gameMode == PlayMode.PRACTICE){
				practiceCount++;
				scoreLabel.text = "" + practiceCount;
			}
			switch (myPlayer.position){
				case 0:{
					var rndVal:Int = Random.int(1, 3);
					if (rndVal == 1){
						var finalPos:FlxPoint = new FlxPoint(positions[3], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,1,time2);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time2;
						aBall.finalPosition = 3;
					}
					else if (rndVal == 2){
						var finalPos:FlxPoint = new FlxPoint(positions[4], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,1,time3);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time3;
						aBall.finalPosition = 4;
					}
					else if (rndVal == 3){
						var finalPos:FlxPoint = new FlxPoint(positions[5], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,1,time4);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time4;
						aBall.finalPosition = 5;
					}
				}
				case 1:{
					var rndVal:Int = Random.int(1, 3);
					if (rndVal == 1){
						var finalPos:FlxPoint = new FlxPoint(positions[3], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,1,time1);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time1;
						aBall.finalPosition = 3;
					}
					else if (rndVal == 2){
						var finalPos:FlxPoint = new FlxPoint(positions[4], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,1,time2);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time2;
						aBall.finalPosition = 4;
					}
					else if (rndVal == 3){
						var finalPos:FlxPoint = new FlxPoint(positions[5], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,1,time3);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time3;
						aBall.finalPosition = 5;
					}
				}
				case 2:{
					var rndVal:Int = Random.int(1, 3);
					if (rndVal == 1){
						var finalPos:FlxPoint = new FlxPoint(positions[3], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,1,time0);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time0;
						aBall.finalPosition = 3;
					}
					else if (rndVal == 2){
						var finalPos:FlxPoint = new FlxPoint(positions[4], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,1,time1);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time1;
						aBall.finalPosition = 4;
					}
					else if (rndVal == 3){
						var finalPos:FlxPoint = new FlxPoint(positions[5], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,1,time2);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time2;
						aBall.finalPosition = 5;
					}
				}
			}
			aBall.count ++;
			aBall.totalTime = time;
			aBall.updateTimer();
			aBall.body.angularVel = 7;
			ballManager.opponentBalls.push(aBall);
		}
		
		else{
			switch (opponent.position){
				case 3:{
					var rndVal:Int = Random.int(1, 3);
					if (rndVal == 1){
						var finalPos:FlxPoint = new FlxPoint(positions[2], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,2,time0);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time0;
						aBall.finalPosition = 2;
					}
					else if (rndVal == 2){
						var finalPos:FlxPoint = new FlxPoint(positions[1], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,2,time1);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time1;
						aBall.finalPosition = 1;
					}
					else if (rndVal == 3){
						var finalPos:FlxPoint = new FlxPoint(positions[0], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,21,time2);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time2;
						aBall.finalPosition = 0;
					}
				}
				case 4:{
					var rndVal:Int = Random.int(1, 3);
					if (rndVal == 1){
						var finalPos:FlxPoint = new FlxPoint(positions[2], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,2,time1);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time1;
						aBall.finalPosition = 2;
					}
					else if (rndVal == 2){
						var finalPos:FlxPoint = new FlxPoint(positions[1], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,2,time2);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time2;
						aBall.finalPosition = 1;
					}
					else if (rndVal == 3){
						var finalPos:FlxPoint = new FlxPoint(positions[0], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,21,time3);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time3;
						aBall.finalPosition = 0;
					}
				}
				case 5:{
					var rndVal:Int = Random.int(1, 3);
					if (rndVal == 1){
						var finalPos:FlxPoint = new FlxPoint(positions[2], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,2,time2);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time2;
						aBall.finalPosition = 2;
					}
					else if (rndVal == 2){
						var finalPos:FlxPoint = new FlxPoint(positions[1], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,2,time3);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time3;
						aBall.finalPosition = 1;
					}
					else if (rndVal == 3){
						var finalPos:FlxPoint = new FlxPoint(positions[0], opponent.getPosition().y + 5);
						var velocity = calculateBallVelocity(aBall,finalPos,21,time4);
						aBall.body.velocity.x =  velocity.x;
						aBall.body.velocity.y = velocity.y;
						time = time4;
						aBall.finalPosition = 0;
					}
				}
			}
			aBall.count ++;
			aBall.totalTime = time;
			aBall.stopTimer();
			aBall.body.angularVel = -7;
			ballManager.opponentBalls.remove(aBall);
		}
		

	}
	
	private function calculateNextBall(){
		var ballToDefend : Ball = null;
		var currentTime:Date = Date.now();
		for(i in 0...ballManager.opponentBalls.length){
			var chosenBall = ballManager.opponentBalls[i];
			if(i == 0){
				ballToDefend = chosenBall;
			}
			else if(chosenBall.totalTime < ballToDefend.totalTime){
				ballToDefend = chosenBall;
			}
		}
		if(ballToDefend != null){
			opponent.moveOpponent(ballToDefend);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	public function updateOpponentPosition(nextPosition:Int) 
	{
		
	}
	
}