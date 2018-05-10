package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import openfl.Assets;

class SelectTeamState extends FlxState
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

		var x:Int = Math.floor(FlxG.width / 4);
		var left_x:Int = x  - 40;
		var right_x:Int = (x * 3) - 40;

		var btn_back = new FlxButton(20, 20, "Back", back);
		add(btn_back);

		var btn_previous_team = new FlxButton(left_x, 50, "<", previous_team);
		var btn_next_team = new FlxButton(right_x, 50, ">", next_team);
		add(btn_next_team);
		add(btn_previous_team);
	}
	
	private function next_team():Void
	{}
	private function previous_team():Void
	{}

	private function back():Void
	{
		trace("vuelta");
		FlxG.switchState(menuState);
	}

}