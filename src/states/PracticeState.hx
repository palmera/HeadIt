package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import openfl.Assets;
import helpers.Tools;

class PracticeState extends FlxState
{

	private var background:FlxSprite;
	private var menuState:MenuState;
	public function new()
	{
		super();
		trace("pepe");
	}

	override function create():Void
	{
		super.create();
		menuState = new MenuState();
		trace("juan");
		background = Tools.getSpriteWithSize('img/practiceBack.png',FlxG.width,FlxG.height);
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