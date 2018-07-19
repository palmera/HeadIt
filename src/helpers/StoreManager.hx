package helpers;
import flixel.system.FlxSound;
import flixel.FlxG;
import gameObjects.Country;
import js.html.Exception;

class StoreManager
{
	private static var instance:StoreManager;
	private static var wallet:WalletManager;

	public static function Instance():StoreManager
	{
		if (instance == null)
		{
			instance = new StoreManager();
		}
		return instance;
	}
	
	public function new(){
		wallet = WalletManager.Instance();
	}

	public function purchase(country:Country):Void
	{
		if (wallet.hasFunds(country.getCost()))
		{
			if (country.isLocked())
			{
				wallet.purchase(country.getCost());
				country.unlock();
			}
			else
			{
				// throw new Exception('Country already unlocked');
			}
		}
	}
}