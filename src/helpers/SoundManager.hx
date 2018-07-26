package helpers;
import flixel.system.FlxSound;
import flixel.FlxG;

/**
 * ...
 * @author 
 */
class SoundManager 
{
	private static var instance:SoundManager;
	
	private var _endMatch:FlxSound;
	
	public static function Instance():SoundManager{
		if(instance == null){
			instance = new SoundManager();
		}
		return instance;
	}
	
	public function new(){

		
	}
	
	public function playMusic(){
		FlxG.sound.playMusic(Sounds.BACKGROUND, 1, true);
	}
	
	
	
	public function playEndMatch(){
		_endMatch = FlxG.sound.load(Sounds.END_MATCH);
		_endMatch.play();
	}
	
	
	
	
	
}