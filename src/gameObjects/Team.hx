package gameObjects;

import flixel.FlxSprite;
import openfl.Assets;

class Team extends FlxSprite {
    var shirt:FlxSprite;
    var head:FlxSprite;
    var name:String;
    var id:Int;

    public function new(name:String) {
		super();
        this.name = name;
		this.head = new FlxSprite();
		this.shirt = new FlxSprite();
    }
	public function set_shirt(path:String):Void {
		this.shirt.loadGraphic(Assets.getBitmapData(path));
	}
	
	public function get_shirt():FlxSprite {
		return this.shirt;
	}
	public function get_head():FlxSprite {
		return this.head;
	}
	public function get_name():String {
		return this.name;
	}
	public function get_player():FlxSprite {
		return this.shirt;
		//var body = new FlxSprite();
		//body.stamp(this.head);
		//body.stamp(this.shirt);
		// var body = this.head.stamp(this.shirt, 0, 30);
		//return body;
	}

}