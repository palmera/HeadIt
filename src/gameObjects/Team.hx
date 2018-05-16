package gameObjects;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import openfl.Assets;
import flixel.FlxG;
import helpers.Tools;

class Team extends FlxSpriteGroup {
    var shirt:FlxSprite;
    public var head:FlxSprite;
	var body:FlxSprite;
    var name:String;
    var id:Int;
	var position:Int;
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
		var headWidth = playerWidth * 216 / 315;
		var headHeight = playerHeight * 268 / 678;
		this.head = Tools.getSpriteWithSize("img/players/" + name+"Head.png", headWidth, headHeight);
		this.head.x = 0;
		this.head.y = 0;
		this.add(this.head);
	}
	private function setShirt():Void {//300*340
		var shirtWidth = playerWidth * 300 / 315;
		var shirtHeight = playerHeight * 340 / 678;
		this.shirt = Tools.getSpriteWithSize("img/players/" + name+"Shirt.png", shirtWidth, shirtHeight);
		this.shirt.x = playerWidth / 1000 - 3;
		this.shirt.y = playerHeight * 229 / 678;
		this.add(this.shirt);
	}
	
	
	private function setBody():Void {
		var bodyWidth = playerWidth * 301 / 315;
		var bodytHeight = playerHeight * 311 / 678;
		this.body = Tools.getSpriteWithSize("img/players/WhiteBody.png", bodyWidth, bodytHeight);
		this.body.x = playerWidth * 6 / 315;
		this.body.y = playerHeight * 367 / 678;
		this.add(this.body);
	}
	
	public function Flip(){
		this.flipX = true;
		this.head.x = playerWidth * 99 / 315;
		this.shirt.x = 0;
		this.body.x = playerWidth * 9 / 315;
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
	

}