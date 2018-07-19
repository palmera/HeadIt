package helpers;
import flixel.FlxSprite;
import gameObjects.Country;

/**
 * ...
 * @author 
 */
class CountryManager 
{
	private static var instance:CountryManager;
	
	public var _countries = new Array();
	
	public function new() 
	{
		var uruguayFlag = new FlxSprite();
		uruguayFlag.loadGraphic('img/Flags/UruguayFlag.png');
		var Uruguay = new Country("Uruguay", uruguayFlag, 8, 0, false);
		
		var argenitnaFlag = new FlxSprite();
		argenitnaFlag.loadGraphic('img/Flags/ArgentinaFlag.png');
		var Argentina = new Country("Argentina", argenitnaFlag, 7, 50, true);
		
		var brasilFlag = new FlxSprite();
		brasilFlag.loadGraphic('img/Flags/BrazilFlag.png');
		var Brasil = new Country("Brazil", brasilFlag, 8, 60, true);
		
		var croatiaFlag = new FlxSprite();
		croatiaFlag.loadGraphic('img/Flags/CroatiaFlag.png');
		var Croatia = new Country("Croatia", croatiaFlag, 8, 90, true);
		
		var englandFlag = new FlxSprite();
		englandFlag.loadGraphic('img/Flags/EnglandFlag.png');
		var England = new Country("England", englandFlag, 6, 70, true);
		
		var portugalFlag = new FlxSprite();
		portugalFlag.loadGraphic('img/Flags/PortugalFlag.png');
		var Portugal = new Country("Portugal", portugalFlag, 6, 50, true);
		
		var russiaFlag = new FlxSprite();
		russiaFlag.loadGraphic('img/Flags/RussiaFlag.png');
		var Russia = new Country("Russia", russiaFlag, 5, 50, true);
		
		var franceFlag = new FlxSprite();
		franceFlag.loadGraphic('img/Flags/FranceFlag.png');
		var France = new Country("France", franceFlag, 5, 100, true);
		
		_countries.push(Uruguay);
		_countries.push(Argentina);
		_countries.push(Brasil);
		_countries.push(Croatia);
		_countries.push(Portugal);
		_countries.push(Russia);
		_countries.push(France);
		_countries.push(England);
	}
	
	public static function Instance():CountryManager{
		if(instance == null){
			instance = new CountryManager();
		}
		return instance;
	}
	
}