package states;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import openfl.Assets;
import gameObjects.Team;
import helpers.TeamList;

class SelectTeamState extends FlxState
{

	private var background:FlxSprite;
	private var teams:TeamList;
	private var current_team:Team;
	public function new()
	{
		super();
	}

	override function create():Void
	{
		super.create();
		this.teams = TeamList.instance;
		background = new FlxSprite();
		background.loadGraphic(Assets.getBitmapData('img/traning-hd.png'));
		add(background);
		
		current_team = teams.get_team_at_pos(0);
		add(current_team.get_player());
		
		loadButtons();
		
	}
	private function loadButtons()
	{
		var x:Int = Math.floor(FlxG.width / 4);
		var left_x:Int = x  - 40;
		var right_x:Int = (x * 3) - 40;

		var btn_back = new FlxButton(20, 20, "Back", back);
		add(btn_back);
		
		var btn_save = new FlxButton(FlxG.width - 30, FlxG.height - 30, "PLAY", play);
		add(btn_save);

		var btn_previous_team = new FlxButton(left_x, 50, "<", previous_team);
		var btn_next_team = new FlxButton(right_x, 50, ">", next_team);
		add(btn_next_team);
		add(btn_previous_team);
	}
	private function next_team():Void
	{
		current_team = teams.get_next_team();
		//trace(current_team.get_name());
		current_team.get_player().update(1); //.update(1);
	}
	private function previous_team():Void
	{
		current_team = teams.get_previous_team();
		//trace(current_team.get_name());
		current_team.get_player().update(1);// update(1);
	}

	private function back():Void
	{
		trace("vuelta");
		FlxG.switchState(new MenuState());
	}
	
	private function play():Void
	{
		FlxG.switchState(new GameState(new Team("Uruguay"),teams.get_team_at_pos(2)));
		// menuState = new MenuState();
		// menuState.selected_team = current_team;
		// FlxG.switchState(menuState);
	}

}