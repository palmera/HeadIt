package;

import flixel.FlxGame;
import openfl.display.Sprite;
import openfl.events.Event;
import states.MenuState;

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
		var game = new FlxGame(0, 0, MenuState); 
		//game.x = 0; 
		//game.y = 0;
		
		addChild(game);
	}
}
