package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import openfl.Assets;
import states.MenuState;

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
		background = new FlxSprite();
		background.loadGraphic(Assets.getBitmapData('img/traning-hd.png'));
		add(background);

		var init_x:Int = Math.floor(FlxG.width / 2 - 40);

		var btn_back = new FlxButton(init_x, 50, "Back", back);
		add(btn_back);
	}
	

	private function back():Void
	{
		trace("vuelta");
		FlxG.switchState(menuState);
	}

}