
package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import openfl.Assets;
import helpers.Tools;

/**
 * ...
 * @author Alejandro Grunwaldt
 */
class TournamentState  extends FlxState
{
	private var background:FlxSprite;
	
	public function new() 
	{
		super();
	}
	
	override function create():Void
	{
		super.create();
		background = Tools.getSpriteWithSize('img/tournamentBack.png',FlxG.width,FlxG.height);
		background.x = 0;
		background.y = 0;
		add(background);
		
		var btn_back = new FlxButton(20, 20, "Back", back);
		add(btn_back);

		var init_x:Int = Math.floor(FlxG.width / 2 - 40);

	}
	
	private function back():Void
	{
		trace("vuelta");
		FlxG.switchState(new SelectModeState());
	}
	
}




	
	
