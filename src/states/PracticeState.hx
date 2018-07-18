package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import openfl.Assets;
import helpers.Tools;
import gameObjects.Button;

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