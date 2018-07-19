package gameObjects;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import openfl.Assets;
import flixel.FlxG;
import helpers.Tools;
import helpers.SoundManager;

class Team extends FlxSpriteGroup {
    public var shirt:FlxSprite;
    public var head:FlxSprite;
	var body:FlxSprite;
    var name:String;
    var id:Int;
	public var position:Int;
	public var isEnemy:Bool;
	
	var playerHeight:Float;
	var playerWidth:Float;

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

	
	private function setHead():Void{
		this.head = new FlxSprite(0, 0, "img/players/" + name+"Head.png");
		this.add(this.head);
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
		SoundManager.Instance().playMove();
		if(position != 2){
			position++;
		}
	}
	public function moveLeft():Void{
		SoundManager.Instance().playMove();
		if(position != 0){
			position --;
		}
	}
	

}