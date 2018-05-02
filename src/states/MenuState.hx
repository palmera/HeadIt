package src.states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import openfl.Assets;

class MenuState extends FlxState
{

	private var background:FlxSprite;
	public function new()
	{
		super();
	}

	override function create():Void
	{
		super.create();
		
		background = new FlxSprite();
		background.loadGraphic(Assets.getBitmapData('img/beach-hd.png'));
		add(background);

		var init_x:Int = Math.floor(FlxG.width / 2 - 40);

		var btn_new = new FlxButton(init_x, 50, "New game", onNew);
		var btn_load = new FlxButton(init_x, 80, "Load", onLoad);
		add(btn_new);
		add(btn_load);
	}
	

	private function onNew():Void
	{
		// FlxG.switchState(new PlayState());
	}

	private function onLoad():Void
	{
		trace("Load...");
	}

}