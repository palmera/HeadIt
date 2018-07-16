package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import openfl.Assets;
import gameObjects.Team;
import helpers.TeamList;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.util.FlxColor;
import helpers.Tools;

class MenuState extends FlxState
{

	private var background:FlxSprite;
	
	public function new()
	{
		super();
	}

	override function create():Void
	{
		super.create();
		FlxG.scaleMode =new FixedScaleMode();
		
		background = Tools.getSpriteWithSize('img/home3.png',FlxG.width,FlxG.height);
		background.x = 0;
		background.y = 0;

		add(background);

		var init_x:Int = Math.floor(FlxG.width / 2 - 40);
		
		var btn_play = new FlxButton(165, 225, "Play", onPlay);
		var btn_credits = new FlxButton(320, 225, "Credits", onCredits);
		add(btn_play);
		add(btn_credits);
	}
	
	private function onPlay(): Void{
		FlxG.switchState(new SelectModeState());
	}
	
	private function onCredits(): Void{
		
	}


}