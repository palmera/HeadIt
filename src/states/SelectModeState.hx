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
import helpers.PlayMode;

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
	private var btn_store: Button;
	
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

		btn_practice = new Button(85, 100, 'img/practiceMode.png', 'img/practiceModeHover.png', 'img/practiceModeClick.png');
		btn_practice.btn.onUp.callback = onPractice;
		btn_quick_game = new Button(20, 355, 'img/quickGameMode.png', 'img/quickGameModeHover.png', 'img/quickGameModeClick.png');
		btn_quick_game.btn.onUp.callback = onSelectTeam;
		btn_tournament = new Button(235, 180, 'img/tournamentMode.png', 'img/tournamentModeHover.png', 'img/tournamentModeClick.png');
		btn_tournament.btn.onUp.callback = onStartTournament;
		btn_store = new Button(535, 280, 'img/Store.png', 'img/StoreHover.png', 'img/StoreClick.png');
		btn_store.btn.onUp.callback = onOpenStore;
		
		add(btn_practice.btn);
		add(btn_quick_game.btn);
		add(btn_tournament.btn);
		add(btn_store.btn);
	}
	
	private function onSelectTeam():Void
	{
	FlxG.switchState(new SelectTeamState(PlayMode.QUICKGAME));
	}
	
	private function onPractice():Void
	{
		FlxG.switchState(new SelectTeamState(PlayMode.PRACTICE));
	}

	private function onStartTournament():Void
	{
		FlxG.switchState(new SelectTeamState(PlayMode.TOURNAMENT));
	}	
	
	private function onOpenStore():Void
	{
		FlxG.switchState(new StoreState());
	}
}







	
