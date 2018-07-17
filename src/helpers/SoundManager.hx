package helpers;

/**
 * ...
 * @author 
 */
class SoundManager 
{
	private static instance:SoundManager;
	
	public static Instance():SoundManager {
		if(instance == null){
			instance = new SoundManager();
		}
		return instance;
	}
	
	
}