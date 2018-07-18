
package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import gameObjects.Country;
import openfl.Assets;
import helpers.Tools;
import gameObjects.Button;
import gameObjects.Country;
import gameObjects.Tournament;

/**
 * ...
 * @author Alejandro Grunwaldt
 */
class TournamentState  extends FlxState
{
	private var background:FlxSprite;
	private var tournament:Tournament;
	
	public function new(country:Country)
	{
		super();
		this.tournament = new Tournament(country);
	}

	
	override function create():Void
	{
		super.create();
		background = Tools.getSpriteWithSize('img/tournamentBack.png',FlxG.width,FlxG.height);
		background.x = 0;
		background.y = 0;
		add(background);
		
		var btn_back = new Button(40, 40, 'img/Buttons/back.png', 'img/Buttons/backHover.png', 'img/Buttons/backClick.png');
		btn_back.btn.onUp.callback = back;
		add(btn_back.btn);

		var init_x:Int = Math.floor(FlxG.width / 2 - 40);

	}
	
	private function back():Void
	{
		trace("vuelta");
		FlxG.switchState(new SelectModeState());
	}
	
}




	
	
