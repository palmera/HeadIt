package states;
import flixel.FlxState;
import flixel.FlxSprite;
import helpers.Tools;
import flixel.FlxG;
import gameObjects.Button;

/**
 * ...
 * @author 
 */
class CreditsState extends FlxState
{
	private var background:FlxSprite;

	public function new() 
	{
		super();
	}
	override function create():Void
	{
		super.create();
		background = Tools.getSpriteWithSize('img/credits.png',FlxG.width,FlxG.height);
		background.x = 0;
		background.y = 0;
		add(background);
		
		var btn_back = new Button(40, 40, 'img/Buttons/back.png', 'img/Buttons/backHover.png', 'img/Buttons/backClick.png');
		btn_back.btn.onUp.callback = back;
		add(btn_back.btn);
	
	}
	
	private function back():Void
	{
		FlxG.switchState(new MenuState());
	}
	
}
