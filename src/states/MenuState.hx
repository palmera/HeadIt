package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import openfl.Assets;
import gameObjects.Team;

class MenuState extends FlxState
{

	private var background:FlxSprite;
	private var teams:List<Team>;
	public var selected_team:Team;
	
	public function new()
	{
		super();
	}

	override function create():Void
	{
		super.create();
		
		teams = System.GetTeams();
		selected_team = teams.first();
		
		background = new FlxSprite();
		background.loadGraphic(Assets.getBitmapData('img/beach-hd.png'));
		add(background);

		var init_x:Int = Math.floor(FlxG.width / 2 - 40);

		var btn_practice = new FlxButton(init_x, 50, "Practice", onPractice);
		var btn_quick_game = new FlxButton(init_x, 80, "Quick Game", onLoad);
		var btn_tournament = new FlxButton(init_x, 110, "Tournament", onLoad);
		var btn_select_team = new FlxButton(init_x, 140, "Select team", onSelectTeam);
		add(btn_practice);
		add(btn_quick_game);
		add(btn_tournament);
		add(btn_select_team);
	}
	
	private function onSelectTeam():Void
	{
		trace("select team menu");
		FlxG.switchState(new SelectTeamState(teams));
	}
	private function onPractice():Void
	{
		trace("olaa");
		FlxG.switchState(new PracticeState());
	}

	private function onLoad():Void
	{
		trace("Load...");
	}


}