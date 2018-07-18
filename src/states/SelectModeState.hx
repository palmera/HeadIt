package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import gameObjects.Button;
import openfl.Assets;
import gameObjects.Team;
import helpers.TeamList;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.util.FlxColor;
import helpers.Tools;


/**
 * ...
 * @author Alejandro Grunwaldt
 */
class SelectModeState extends FlxState
{
	private var background:FlxSprite;
	private var btn_practice: Button;
	private var btn_quick_game: Button;
	private var btn_tournament: Button;
	
	public function new() 
	{
		super();
	}
	
	override function create():Void
	{
		super.create();
		FlxG.scaleMode =new FixedScaleMode();
		
		background = Tools.getSpriteWithSize('img/selectMode.png',FlxG.width,FlxG.height);
		background.x = 0;
		background.y = 0;

		add(background);

		btn_practice = new Button(82, 64, 'img/practiceMode.png', 'img/practiceModeHover.png', 'img/practiceModeClick.png');
		btn_practice.btn.onUp.callback = onPractice;
		btn_quick_game = new Button( 60, 370, 'img/quickGameMode.png', 'img/quickGameModeHover.png', 'img/quickGameModeClick.png');
		btn_quick_game.btn.onUp.callback = onSelectTeam;
		btn_tournament = new Button(365, 182, 'img/tournamentMode.png', 'img/tournamentModeHover.png', 'img/tournamentModeClick.png');
		btn_tournament.btn.onUp.callback = onLoad;
		
		add(btn_practice.btn);
		add(btn_quick_game.btn);
		add(btn_tournament.btn);
	}
	
	private function onSelectTeam():Void
	{
		FlxG.switchState(new SelectTeamState());
	}
	
	private function onPractice():Void
	{
		FlxG.switchState(new PracticeState());
	}

	private function onLoad():Void
	{
		FlxG.switchState(new TournamentState());
	}	
}







	
