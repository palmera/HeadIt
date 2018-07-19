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
		var uruguayLockedFlag = new FlxSprite();
		uruguayLockedFlag.loadGraphic('img/Flags/UruguayLockedFlag.png');
		var Uruguay = new Country("Uruguay", uruguayFlag, uruguayLockedFlag, 8, 0, false);
		
		var argenitnaFlag = new FlxSprite();
		argenitnaFlag.loadGraphic('img/Flags/ArgentinaFlag.png');
		var argenitnaLockedFlag = new FlxSprite();
		argenitnaLockedFlag.loadGraphic('img/Flags/ArgentinaLockedFlag.png');
		var Argentina = new Country("Argentina", argenitnaFlag, argenitnaLockedFlag, 7, 50, true);
		
		var brasilFlag = new FlxSprite();
		brasilFlag.loadGraphic('img/Flags/BrazilFlag.png');
		var brasilLockedFlag = new FlxSprite();
		brasilLockedFlag.loadGraphic('img/Flags/BrazilLockedFlag.png');
		var Brasil = new Country("Brazil", brasilFlag, brasilLockedFlag, 8, 60, true);
		
		var croatiaFlag = new FlxSprite();
		croatiaFlag.loadGraphic('img/Flags/CroatiaFlag.png');
		var croatiaLockedFlag = new FlxSprite();
		croatiaLockedFlag.loadGraphic('img/Flags/CroatiaLockedFlag.png');
		var Croatia = new Country("Croatia", croatiaFlag, croatiaLockedFlag, 8, 90, true);
		
		var englandFlag = new FlxSprite();
		englandFlag.loadGraphic('img/Flags/EnglandFlag.png');
		var englandLockedFlag = new FlxSprite();
		englandLockedFlag.loadGraphic('img/Flags/EnglandLockedFlag.png');
		var England = new Country("England", englandFlag, englandLockedFlag, 6, 70, true);
		
		var portugalFlag = new FlxSprite();
		portugalFlag.loadGraphic('img/Flags/PortugalFlag.png');
		var portugalLockedFlag = new FlxSprite();
		portugalLockedFlag.loadGraphic('img/Flags/PortugalLockedFlag.png');
		var Portugal = new Country("Portugal", portugalFlag, portugalLockedFlag, 6, 50, true);
		
		var russiaFlag = new FlxSprite();
		russiaFlag.loadGraphic('img/Flags/RussiaFlag.png');
		var russiaLockedFlag = new FlxSprite();
		russiaLockedFlag.loadGraphic('img/Flags/RussiaLockedFlag.png');
		var Russia = new Country("Russia", russiaFlag, russiaLockedFlag, 5, 50, true);
		
		var franceFlag = new FlxSprite();
		franceFlag.loadGraphic('img/Flags/FranceFlag.png');
		var franceLockedFlag = new FlxSprite();
		franceLockedFlag.loadGraphic('img/Flags/FranceLockedFlag.png');
		var France = new Country("France", franceFlag, franceLockedFlag, 5, 100, true);
		
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