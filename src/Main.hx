package;

import openfl.display.Sprite;
import openfl.Lib;
import openfl.events.Event;
import flixel.FlxGame;
import src.states.MenuState;

/**
 * ...
 * @author Alejandro Grunwaldt
 */
class Main extends Sprite 
{

	public function new() 
	{
		super();
		
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
		addEventListener(Event.ADDED_TO_STAGE, init);
		
	}
	
	private function init(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);
		addChild(new FlxGame(800, 480, MenuState));
	}
}
