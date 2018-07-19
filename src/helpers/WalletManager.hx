package helpers;
import flixel.system.FlxSound;
import flixel.FlxG;
import js.html.Exception;

/**
 * ...
 * @author 
 */
class WalletManager 
{
	private static var instance:WalletManager;
	
	private var _wallet:Int;
	
	public static function Instance():WalletManager{
		if(instance == null){
			instance = new WalletManager();
		}
		return instance;
	}
	
	public function new(){
		_wallet = 200;
	}
	
	public function addMoney(amount:Int){
		this._wallet = this._wallet + amount;
	}
	
	public function hasFunds(amount:Int):Bool{
		return _wallet >= amount;
	}
	
	public function getFunds(): Int
	{
		return this._wallet;
	}
	
	public function purchase(cost:Int){
		if (this._wallet >= cost) 
		{
			this._wallet = this._wallet - cost;
		} else {
			// throw new Exception('Insuficient funds');
		}
		
	}
}