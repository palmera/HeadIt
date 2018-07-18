package gameObjects;
import flixel.FlxSprite;
import gameObjects.Team;

/**
 * ...
 * @author 
 */
class Country 
{
	private var name: String;
	private var countryFlag: FlxSprite;
	private var difficulty:Int;
	private var team: Team;

	public function new(name: String, flag:FlxSprite, difficulty:Int) 
	{
		this.name = name;
		this.countryFlag = flag;
		this.difficulty = difficulty;
		var team = new Team(name);
		this.team = team;
	}
	
	public function getName():String{
		return name;
	}
	
	public function getFlag():FlxSprite{
		return countryFlag;
	}
	
	public function getTeam():Team{
		return team;
	}
	
}