package states;
import flixel.FlxState;
import flixel.text.FlxText;
import gameObjects.Ball;
import gameObjects.Team;
import flixel.FlxG;
import flixel.math.FlxPoint;
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
//import helpers.PlayMode;
/**
 * ...
 * @author 
 */
class MatchState extends FlxState
{
	public var myPlayer:Team;
	var opponent:Team;
	
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
	
	
	public var PLAYER_Y_POS:Float = 255;
	
	private function setVariables(){
		screenHeight = FlxG.height;
		screenWidth = FlxG.width;
		myScore = 0;
		opponentScore = 0;
		loadPoints();
	}
	
	private function setAssets(){
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
		
		enemyFrontGoalPosts = Tools.getSpriteWithSize("img/GoalFront-hd.png", -180, 263);
		enemyFrontGoalPosts.y = 228;
		enemyFrontGoalPosts.x = 762;
		add(enemyFrontGoalPosts);
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
	
	private function setBalls(){
		ballManager = new BallManager(positions, this);
		add(ballManager);
	}
	
	private function setScoreLabel(){
		/*if(gameMode == PlayMode.PRACTICE){
			scoreLabel = new FlxText(screenWidth / 2, screenHeight * 0.05,0,""+myScore,16);
		}
		else{*/
			scoreLabel = new FlxText(0, screenHeight * 0.05,screenWidth,myPlayer.get_name()+" "+myScore+" - "+opponentScore+" "+opponent.get_name());
		//}
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
		
	}
	override public function create():Void{
		setVariables();
		setAssets();
		
		setScoreLabel();
		loadTeams();
		
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
		floor.y = ground-1;
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
		
		
	
		
		
		setBalls();
		loadPosts();
	}
	
	public function new(team1:Team,team2:Team, mode:Int) 
	{
		super();
		
		gameMode = mode;
		myPlayer = team1;
		opponent = team2;
		
		
		
		
		
		/*
		 * 
   - (id)initWithType:(NSString *)gameType andSubType:(NSString *)gameSubType andOpponent:(Player *)opponentPlayer

    

    
            [self schedule:@selector(decreaseTime) interval:1];
    
    

  
    
    
    
    //[self addBall];
    field = [CCSprite spriteWithImageNamed:@"optionBox.png"];
    field.opacity = 0;
    field.position=ccp(0,19);
    CGRect rect = CGRectMake(-field.contentSize.width, field.contentSize.height/2, 3*screenWidth, 10);
    field.physicsBody = [CCPhysicsBody bodyWithRect:rect cornerRadius:0];
    field.physicsBody.type = CCPhysicsBodyTypeStatic;
    field.physicsBody.elasticity=1;
    field.physicsBody.collisionType = @"fieldCollision";
    //self.physicsWorld.debugDraw=YES;
    
    CCSprite* leftNet = [CCSprite spriteWithImageNamed:@"optionBox.png"];
    leftNet.opacity = 0;
    leftNet.position=ccp(0,19);
    CGRect netRect = CGRectMake(screenWidth*0.195, screenHeight*0.2, 20, screenHeight);
    leftNet.physicsBody = [CCPhysicsBody bodyWithRect:netRect cornerRadius:0];
    leftNet.physicsBody.type = CCPhysicsBodyTypeStatic;
    leftNet.physicsBody.elasticity=0.0000000001;
   
    CCSprite* rightNet = [CCSprite spriteWithImageNamed:@"optionBox.png"];
    rightNet.opacity = 0;
    rightNet.position=ccp(0,19);
    CGRect rightRect = CGRectMake(screenWidth*1.2, screenHeight*0.2, 20, screenHeight*0.4);
    rightNet.physicsBody = [CCPhysicsBody bodyWithRect:rightRect cornerRadius:0];
    rightNet.physicsBody.type = CCPhysicsBodyTypeStatic;
    rightNet.physicsBody.elasticity=0.0000000001;
    
    
    
    
    
    
    //Agrego physics body a las cabezas
    
    [self.physicsWorld addChild:player.physicsHead];
    [self.physicsWorld addChild:field];
    [self.physicsWorld addChild:leftNet];
    [self.physicsWorld addChild:rightNet];
    //count++;
    
    [self.physicsWorld addChild:opponent.physicsHead];
    
    level=1;//DESPUES CAMBIAR
    if([subType isEqualToString:@"Group"]||[subType isEqualToString:@"Knockout"]){
        level=data.currentTournament.currentStage;
    }
    
    [self loadEfficiency];
    [self loadTimes];
    
    self.userInteractionEnabled = YES;

    pauseButton=[CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"pauseGame.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"pauseGame.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"coinBox.png"]];
    [pauseButton setTarget:self selector:@selector(onPauseClicked)];
    pauseButton.positionType=CCPositionTypeNormalized;
    pauseButton.position=ccp(0.9,0.9);
    [self addChild:pauseButton];
    
    return self;

		 * */
	}
	
	
	override public function update(elapsed:Float):Void
	{
		/*timerCounter += elapsed;
		if (timerCounter > maxTimerCounter && !hasStarted){
			startGame();
			timerCounter = 0;
		}
		if (hasStarted){
			for(ball in ballManager.balls){
				FlxG.overlap(myPlayer.head, ball, playerBallCollision);
				FlxG.overlap(opponent.head, ball, playerBallCollision);
			}
			
		}*/
		
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
	
	
	function ballFloorCollision(aFloor:FlxObject, aBall:FlxObject):Void
	{
		var ball = cast(aBall, Ball);
		trace("piso");
		
	}
function playerBallCollision(aPlayer:FlxObject, aBall:FlxObject):Void
	{
		var ball = cast(aBall, Ball);
		
		var collidedWithPlayer = ball.x < FlxG.width / 2;
		var collidedWithOpponent = ball.x > FlxG.width / 2;
		
		if (collidedWithPlayer) {
			//SoundManager.Instance().playHeadBall();
			//trace("col");
			
		} 
		
		
		
		
		
	}
	
	public function updateOpponentPosition(nextPosition:Int) 
	{
		
	}
	
}