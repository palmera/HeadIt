package states;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import openfl.Assets;
import gameObjects.Team;
import helpers.TeamList;
import helpers.Tools;

class SelectTeamState extends FlxState
{
	
	private var background:FlxSprite;
	private var btn_flag:FlxButton;
	private var teams:TeamList;
	private var current_team:Team;
	private var countryFlag: FlxSprite;
	private var countries = new Array();
	private var current_index: Int;
	
	public function new()
	{
		super();
	}

	override function create():Void
	{
		super.create();
		this.teams = TeamList.instance;
		var init_x:Int = Math.floor(FlxG.width / 2 - 40);
		
		background = Tools.getSpriteWithSize('img/quickGameBack.png',FlxG.width,FlxG.height);
		background.x = 0;
		background.y = 0;
		add(background);
		
		countries.push("Uruguay");
		countries.push("Argentina");
		countries.push("Chile");
		countries.push("Brazil");
		current_index  = 0;
		
		btn_flag = new FlxButton(225, 132, "", onCountry);
		var current_country = countries[current_index];
		btn_flag.loadGraphic('img/Flags/'+current_country+'Flag.png');
		add(btn_flag);
		
		current_team = teams.get_team_at_pos(0);
		add(current_team.get_player().head);
		
		loadButtons();
		
	}
	private function loadButtons()
	{
		var x:Int = Math.floor(FlxG.width / 4);
		var left_x:Int = x  - 40;
		var right_x:Int = (x * 3) - 40;

		var btn_back = new FlxButton(20, 20, "Back", back);
		add(btn_back);
		
		var btn_save = new FlxButton(465, FlxG.height - 30, "PLAY", play);
		add(btn_save);

		var btn_previous_team = new FlxButton(left_x, 150, "<", previous_team);
		var btn_next_team = new FlxButton(right_x, 150, ">", next_team);
		add(btn_next_team);
		add(btn_previous_team);
	}
	private function next_team():Void
	{
		if (current_index == 3){
			current_index = 0;
		}else{
			current_index ++;
		}
		var current_country = countries[current_index];
		btn_flag.loadGraphic('img/Flags/'+current_country+'Flag.png');
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
		FlxG.switchState(new SelectModeState());
	}
	
	private function play():Void
	{
		FlxG.switchState(new GameState(new Team(countries[current_index]), new Team("Brazil")));
		// menuState = new MenuState();
		// menuState.selected_team = current_team;
		// FlxG.switchState(menuState);
	}
	
	private function onCountry():Void{
		
	}

}