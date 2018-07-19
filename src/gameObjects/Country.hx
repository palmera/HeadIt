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
	private var countryLockedFlag: FlxSprite;
	private var difficulty:Int;
	private var team: Team;
	private var cost: Int;
	private var locked: Bool;

	public function new(name: String, flag:FlxSprite, lockedFlag:FlxSprite, difficulty:Int, cost:Int, locked:Bool) 
	{
		this.name = name;
		this.countryFlag = flag;
		this.countryLockedFlag = lockedFlag;
		this.difficulty = difficulty;
		this.cost = cost;
		this.locked = locked;
		var team = new Team(name);
		this.team = team;
	}
	
	public function getName():String{
		return name;
	}
	
	public function getFlag():FlxSprite{
		if (this.isLocked()) 
		{
			return countryLockedFlag;
		} else {
			return countryFlag;
		}
	}
	
	public function getTeam():Team{
		return team;
	}
	
	public function getCost(): Int{
		return cost;
	}
	
	public function isLocked(): Bool{
		return locked;
	}
	
	public function unlock(): Void{
		locked = false;
	}
	
}