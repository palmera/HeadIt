package gameObjects;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import openfl.Assets;
import flixel.FlxG;
import helpers.Tools;
import helpers.SoundManager;
import gameObjects.Ball;
import haxe.Timer;
import flixel.math.FlxPoint;

class Team extends FlxSpriteGroup {
    public var shirt:FlxSprite;
    public var head:FlxSprite;
	public var collisionHead:FlxSprite;
	var body:FlxSprite;
    var name:String;
    var id:Int;
	public var position:Int;
	public var isEnemy:Bool;
	
	var playerHeight:Float;
	var playerWidth:Float;
	var positions :Array<Float>;

    public function new(name:String) {
		super();
        this.name = name;
		this.isEnemy = false;
		playerHeight = FlxG.height * 0.4;
		playerWidth = playerHeight * 315 / 678;
		position = 0;
		setHead();
		setBody();
		setShirt();
    }
	
	public function setPositions(p:Array<Float>){
		positions = p;
	}
	
	

	
	private function setHead():Void{
		this.head = new FlxSprite(0, 0, "img/players/" + name+"Head.png");
		this.add(this.head);
		
		this.collisionHead = Tools.getSpriteWithSize("img/players/" + name+"Head.png", 65, 65);
		this.collisionHead.x = 22;
		this.collisionHead.y = 0;
		this.collisionHead.set_visible(false);
		this.add(this.collisionHead);	
		
	}
	private function setShirt():Void {//300*340
		this.shirt = new FlxSprite(0, 0, "img/players/" + name+"Shirt.png");
		this.add(this.shirt);
	}
	
	
	private function setBody():Void {
		this.body = new FlxSprite(0, 0, "img/players/WhiteBody.png");
		this.add(this.body);
	}
	
	public function Flip(){
		this.flipX = true;

	}
	
	public function get_name():String {
		return this.name;
	}

	public function get_player():Team {
		return this;
	}
	
	public function getHeadOffset():Float{
		return this.head.x;
	}
	
	public function getWidth():Float{
		return playerWidth;
	}
	
	public function getCurrentPosition():Int{
		return position;
	}
	
	public function moveRight():Void{
		if(position != 2){
			position++;
		}
	}
	public function moveLeft():Void{
		if(position != 0){
			position --;
		}
	}
	
	private function opponentNextPosition(aBall:Ball):Float{
		return positions[aBall.finalPosition];
	}
	
	public function moveOpponent(aBall:Ball){
		var currentDate:Date = Date.now();
		var timeDifference = aBall.totalTime;
		if (aBall.finalPosition != this.position){
			var nextPos = opponentNextPosition(aBall);
			if(aBall.finalPosition - this.position == -1 || aBall.finalPosition - this.position == 1 ){
				var delay = new Timer(Std.int(timeDifference * 1000 / 2));
				delay.run = function(){
					this.x = nextPos;
					this.position = aBall.finalPosition;
					delay.stop();
				}
			}
			else{
				var delay = new Timer(Std.int(timeDifference * 1000 / 4));
				delay.run = function(){
					this.x = positions[4];
					delay.stop();
					var move = new Timer(Std.int(timeDifference * 1000 / 4));
					move.run = function(){
						this.x = nextPos;
						this.position = aBall.finalPosition;
						move.stop();
					}
				}
				
			}
		}
	}
	

}