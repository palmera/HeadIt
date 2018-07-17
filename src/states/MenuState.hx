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
import gameObjects.Button;

class MenuState extends FlxState
{
	
	private var background:FlxSprite;
	private var btn_play: Button;
	private var btn_credits: Button;
	
	public function new()
	{
		super();
	}

	override function create():Void
	{
		super.create();
		// FlxG.scaleMode =new FixedScaleMode();
		
		background = Tools.getSpriteWithSize('img/home3.png',FlxG.width,FlxG.height);
		background.x = 0;
		background.y = 0;

		add(background);
		
		btn_play = new Button(165, 225, 'img/Buttons/play1.png', 'img/Buttons/play2.png', 'img/Buttons/play3.png');
		btn_play.btn.onUp.callback = onPlay;
		
		btn_credits = new Button(320, 225, 'img/Buttons/credits1.png', 'img/Buttons/credits2.png', 'img/Buttons/credits3.png');
		btn_credits.btn.onUp.callback = onCredits;
		
		add(btn_play.btn);
		add(btn_credits.btn);
	}
	
	private function onPlay(): Void{
		FlxG.switchState(new SelectModeState());
	}
	
	private function onCredits(): Void{
		
	}
}