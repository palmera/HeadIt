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
		
		background = Tools.getSpriteWithSize('img/beach-hd.png',FlxG.width,FlxG.height);
		background.x = 0;
		background.y = 0;

		add(background);


		var init_x:Int = Math.floor(FlxG.width / 2 - 40);

		var btn_practice = new FlxButton(init_x, 50, "Practice", onPractice);
		var btn_quick_game = new FlxButton(init_x, 80, "Quick Game", onSelectTeam);
		var btn_tournament = new FlxButton(init_x, 110, "Tournament", onLoad);
		add(btn_practice);
		add(btn_quick_game);
		add(btn_tournament);
	}
	
	private function onSelectTeam():Void
	{
		trace("select team menu");
		FlxG.switchState(new SelectTeamState());
	}
	private function onPractice():Void
	{
		trace("olaa");
		FlxG.switchState(new PracticeState());
	}

	private function onLoad():Void
	{
				FlxG.scaleMode =new FixedScaleMode();

		trace("Load...");
	}


}