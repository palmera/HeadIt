package states;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import openfl.Assets;
import gameObjects.Team;
import helpers.TeamList;
import helpers.Tools;
import gameObjects.Button;
import helpers.CountryManager;

class SelectTeamState extends FlxState
{
	
	private var background:FlxSprite;
	private var btn_flag:FlxButton;
	private var current_index: Int;
	
	public function new()
	{
		super();
	}

	override function create():Void
	{
		super.create();
		//this.teams = TeamList.instance;
		var init_x:Int = Math.floor(FlxG.width / 2 - 40);
		
		background = Tools.getSpriteWithSize('img/quickGameBack.png',FlxG.width,FlxG.height);
		background.x = 0;
		background.y = 0;
		add(background);
		current_index  = 0;
		
		btn_flag = new FlxButton(225, 132);
		var current_country = CountryManager.Instance()._countries[current_index];
		var countryFlag = current_country.getFlag();
		btn_flag.loadGraphicFromSprite(countryFlag);
		add(btn_flag);
		
		//current_team = teams.get_team_at_pos(0);
		//add(current_team.get_player().head);
		
		loadButtons();
		
	}
	private function loadButtons()
	{
		var x:Int = Math.floor(FlxG.width / 4);
		var left_x:Int = x  - 40;
		var right_x:Int = (x * 3) - 40;

		var btn_back = new Button(40, 40, 'img/Buttons/back.png', 'img/Buttons/backHover.png', 'img/Buttons/backClick.png');
		btn_back.btn.onUp.callback = back;
		add(btn_back.btn);
		
		var btn_save = new Button(775, 440, 'img/Buttons/play.png', 'img/Buttons/playHover.png', 'img/Buttons/playClick.png');
		btn_save.btn.onUp.callback = play;
		add(btn_save.btn);

		var btn_previous_team = new Button(200, 250, 'img/Buttons/previous.png', 'img/Buttons/previousHover.png', 'img/Buttons/previousClick.png');
		btn_previous_team.btn.onUp.callback = previous_team;
		add(btn_previous_team.btn);
		var btn_next_team = new Button(700, 250, 'img/Buttons/next.png', 'img/Buttons/nextHover.png', 'img/Buttons/nextClick.png');
		btn_next_team.btn.onUp.callback = next_team;
		add(btn_next_team.btn);
	}
	private function next_team():Void
	{
		if (current_index == 7){
			current_index = 0;
		}else{
			current_index ++;
		}
		var current_country = CountryManager.Instance()._countries[current_index];
		var countryFlag = current_country.getFlag();
		btn_flag.loadGraphicFromSprite(countryFlag);
		
		
		
		/*var current_country = CountryManager.Instance()._countries[current_index];
		btn_flag.loadGraphic('img/Flags/'+current_country+'Flag.png');
		current_team = teams.get_next_team();
		//trace(current_team.get_name());
		current_team.get_player().update(1); //.update(1);*/
	}
	private function previous_team():Void
	{
		if (current_index == 0){
			current_index = 7;
		}else{
			current_index --;
		}
		var current_country = CountryManager.Instance()._countries[current_index];
		var countryFlag = current_country.getFlag();
		btn_flag.loadGraphicFromSprite(countryFlag);
	}

	private function back():Void
	{
		trace("vuelta");
		FlxG.switchState(new SelectModeState());
	}
	
	private function play():Void
	{
		var playerTeam = CountryManager.Instance()._countries[current_index].getTeam();
		
		var oponentTeam = new Team("Brazil");
		FlxG.switchState(new GameState(playerTeam, oponentTeam));
		// menuState = new MenuState();
		// menuState.selected_team = current_team;
		// FlxG.switchState(menuState);
	}
	
	private function onCountry():Void{
		
	}

}