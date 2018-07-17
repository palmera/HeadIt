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
	
	private var _goal:FlxSound;
	private var _headBall:FlxSound;
	private var _button:FlxSound;
	private var _move:FlxSound;
	
	public static function Instance():SoundManager{
		if(instance == null){
			instance = new SoundManager();
		}
		return instance;
	}
	
	public function new(){
		_goal =  FlxG.sound.load(Sounds.GOAL);
		_headBall =  FlxG.sound.load(Sounds.HEAD_BALL);
		_button =  FlxG.sound.load(Sounds.BUTTON_CLICK);
		_move =  FlxG.sound.load(Sounds.PLAYER_MOVE);
	}
	
	public function playMusic(){
		FlxG.sound.playMusic(Sounds.BACKGROUND, 1, true);
	}
	
	public function playGoal(){
		_goal.play();
	}
	
	public function playHeadBall(){
		_headBall.play();
	}
	
	public function playButton(){
		 _button.play();
	}
	
	public function playMove(){
		 _move.play();
	}
	
	
	
	
	
}