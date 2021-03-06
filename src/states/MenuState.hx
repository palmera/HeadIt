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
import helpers.SoundManager;

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
		SoundManager.Instance().playMusic();
		// FlxG.scaleMode =new FixedScaleMode();
		
		background = Tools.getSpriteWithSize('img/home3.png',FlxG.width,FlxG.height);
		background.x = 0;
		background.y = 0;

		add(background);
		
		var halfWidth = Std.int(FlxG.width/2);
		btn_play = new Button(halfWidth - 109 - 50, 325, 'img/Buttons/play.png', 'img/Buttons/playHover.png', 'img/Buttons/playClick.png');
		btn_play.btn.onUp.callback = onPlay;
		
		btn_credits = new Button(halfWidth + 50, 325, 'img/Buttons/credits.png', 'img/Buttons/creditsHover.png', 'img/Buttons/creditsClick.png');
		btn_credits.btn.onUp.callback = onCredits;
		
		add(btn_play.btn);
		add(btn_credits.btn);
	}
	
	private function onPlay(): Void{
		FlxG.switchState(new SelectModeState());
	}
	
	private function onCredits(): Void{
		FlxG.switchState(new CreditsState());
	}
}