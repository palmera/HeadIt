package states;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import openfl.Assets;
import gameObjects.Team;

class SelectTeamState extends FlxState
{

	private var background:FlxSprite;
	private var menuState:MenuState;
	private var teams:List<Team>;
	private var current_team:Team;
	public function new(teams:List<Team>)
	{
		super();
		this.teams = teams;
	}

	override function create():Void
	{
		super.create();
		background = new FlxSprite();
		background.loadGraphic(Assets.getBitmapData('img/traning-hd.png'));
		add(background);
		loadButtons();
		
	}
	private function loadButtons()
	{
		var x:Int = Math.floor(FlxG.width / 4);
		var left_x:Int = x  - 40;
		var right_x:Int = (x * 3) - 40;

		var btn_back = new FlxButton(20, 20, "Back", back);
		add(btn_back);
		
		var btn_save = new FlxButton(FlxG.width - 30, FlxG.height - 30, "Save", save);
		add(btn_save);

		var btn_previous_team = new FlxButton(left_x, 50, "<", previous_team);
		var btn_next_team = new FlxButton(right_x, 50, ">", next_team);
		add(btn_next_team);
		add(btn_previous_team);
	}
	
	private function next_team():Void
	{}
	private function previous_team():Void
	{}

	private function back():Void
	{
		trace("vuelta");
		FlxG.switchState(menuState);
	}
	
	private function save():Void
	{
		menuState = new MenuState();
		menuState.selected_team = current_team;
		FlxG.switchState(menuState);
	}

}