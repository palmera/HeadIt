package gameObjects;

import flixel.FlxSprite;

class Team extends FlxSprite {
    var shirt:FlxSprite;
    var head:FlxSprite;
    var name:String;
    var id:Int;

    public function new(name:String) {
		super();
        this.name = name;
    }

}