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


/**
 * ...
 * @author Alejandro Grunwaldt
 */
class SelectModeState extends FlxState
{
	private var background:FlxSprite;
	private var btn_practice: FlxButton;
	private var btn_quick_game: FlxButton;
	private var btn_tournament: FlxButton;
	
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


		var init_x:Int = Math.floor(FlxG.width / 2 - 40);

		btn_practice = new FlxButton(80, 0, "", onPractice);
		btn_practice.loadGraphic('img/practiceMode.png');
		btn_practice.onOver.callback = practiceHover;
		btn_practice.onOut.callback = practiceOnOut;
		btn_quick_game = new FlxButton(0, 205, "", onSelectTeam);
		btn_quick_game.loadGraphic('img/quickGameMode.png');
		btn_quick_game.onOver.callback = quickGameHover;
		btn_quick_game.onOut.callback = quickGameOnOut;
		btn_tournament = new FlxButton(150, 105, "", onLoad);
		btn_tournament.loadGraphic('img/tournamentMode.png');
		btn_tournament.onOver.callback = tournamentHover;
		btn_tournament.onOut.callback = tournamentOnOut;
		add(btn_practice);
		add(btn_quick_game);
		add(btn_tournament);
		
		var btn_practice = new FlxButton(80, 225, "Practice", onPractice);
		var btn_quick_game = new FlxButton(init_x, 225, "Quick Game", onSelectTeam);
		var btn_tournament = new FlxButton(400, 225, "Tournament", onLoad);

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
		FlxG.switchState(new TournamentState());
	}
	
	private function practiceHover():Void
	{
		btn_practice.loadGraphic('img/practiceModeHover.png');
	}
	
	private function quickGameHover():Void
	{
		btn_quick_game.loadGraphic('img/quickGameModeHover.png');
	}
	
	private function tournamentHover():Void
	{
		btn_tournament.loadGraphic('img/tournamentModeHover.png');
	}
	
	
	private function practiceOnOut():Void
	{
		btn_practice.loadGraphic('img/practiceMode.png');
	}
	
	private function quickGameOnOut():Void
	{
		btn_quick_game.loadGraphic('img/quickGameMode.png');
	}
	
	private function tournamentOnOut():Void
	{
		btn_tournament.loadGraphic('img/tournamentMode.png');
	}
	
	
}







	
