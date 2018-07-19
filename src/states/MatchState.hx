package states;
import flixel.FlxState;
import flixel.text.FlxText;
import gameObjects.Team;
import flixel.FlxG;
import flixel.math.FlxPoint;
import helpers.Tools;
import flixel.FlxSprite;
import helpers.BallManager;
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
	
	var ballManager:BallManager;
	
	
	public var PLAYER_Y_POS:Float = 6 * (FlxG.height / 11);
	
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
		loadPosts();
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
		//TODO: x e y
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
	}
	
	private function setScoreLabel(){
		/*if(gameMode == PlayMode.PRACTICE){
			scoreLabel = new FlxText(screenWidth / 2, screenHeight * 0.05,0,""+myScore,16);
		}
		else{*/
			scoreLabel = new FlxText(screenWidth / 2, screenHeight * 0.05,0,myPlayer.get_name()+" "+myScore+" - "+opponentScore+" "+opponent.get_name(),60);
		//}
		scoreLabel.setFormat("fonts/Supersonic-Rocketship.ttf");
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
	
	
	public function new(team1:Team,team2:Team, mode:Int) 
	{
		super();
		myPlayer = team1;
		opponent = team2;
		
		setVariables();
		setAssets();
		setBalls();
		gameMode = mode;
		setScoreLabel();
		loadTeams();
		
		
		
		/*
		 * 
   - (id)initWithType:(NSString *)gameType andSubType:(NSString *)gameSubType andOpponent:(Player *)opponentPlayer

    

    
            [self schedule:@selector(decreaseTime) interval:1];
    
    
    
    
    
   
    player.position=ccp(point1.x,0.20f*screenHeight);
    opponent.position=ccp(point6.x,0.20f*screenHeight);
    //player.scale=0.4;
    opponent.scale=0.4;
    //player.physicsHead.scale=0.4;
    player.head.opacity=0;
    player.scaleX=-0.4;
    player.scaleY=0.4;
    player.physicsHead.scaleY=0.4;
    player.physicsHead.scaleX=-0.4;
    opponent.head.opacity=0;
    player.physicsHead.position=ccp(point1.x+0.012f*screenWidth,0.427f*screenHeight);
    opponent.physicsHead.position=ccp(point6.x-0.012f*screenWidth,0.427f*screenHeight);
    player.yBodyPos=player.position.y;
    player.yHeadPos=player.physicsHead.position.y;
    opponent.yBodyPos=opponent.position.y;
    opponent.yHeadPos=opponent.physicsHead.position.y;
    player.physicsHead.physicsBody.type = CCPhysicsBodyTypeStatic;
    player.physicsHead.physicsBody.collisionType=@"headCollision";
    opponent.physicsHead.physicsBody.type = CCPhysicsBodyTypeStatic;
    opponent.physicsHead.physicsBody.collisionType=@"headCollision";
    opponent.physicsHead.scale=0.4;
    //[self addChild:player];
    //[self addChild:opponent];
    
    allBalls =[[NSMutableArray alloc]init];

    [self addChild:player z:2];
    [self addChild:opponent z:2];
    //Cada 6 segundos ejecuta el metodo addBall
    [self schedule:@selector(addBall) interval:8];
    //timer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(addBall) userInfo:nil repeats:YES];
    
    self.physicsWorld = [CCPhysicsNode node];
    self.physicsWorld.gravity = ccp(0,-800);
    // self.physicsWorld.debugDraw = YES;
    self.physicsWorld.collisionDelegate = self;
    [self addChild:self.physicsWorld z:10];
    
    
    
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
	
	public function updateOpponentPosition(nextPosition:Int) 
	{
		
	}
	
}