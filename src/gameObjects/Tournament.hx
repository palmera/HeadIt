package gameObjects;
import gameObjects.Country;
import helpers.TournamentStages;
import helpers.CountryManager;
import Random;
/**
 * ...
 * @author ...
 */
class Tournament 
{
	private var playerCountry: Country;
	private var tournamentState: Int;
	private var participatingCountries:Array<Country> = [];
	private var semifinalsCountries:Array<Country> = [];
	private var finalCountries:Array<Country> = [];
	private var champion:Country;
	
	public var quarterFinalPrize = 10;
	public var semiFinalPrize = 20;
	public var finalPrize = 40;

	public function new(country : Country) 
	{
		this.tournamentState = TournamentStages.RoundOfFour;
		this.playerCountry = country;
		setParticipants();
	}
	
	private function setParticipants():Void
	{
		var allCountries:Array<Country> = CountryManager.Instance()._countries.copy();
		allCountries.remove(playerCountry);
		Random.shuffle(allCountries);
		participatingCountries.insert(0, this.playerCountry);
		for (country in allCountries){
			participatingCountries.push(country);
		}
	}
	
	public function getParticipatingCountries():Array<Country>{
		return participatingCountries;
	}
	
	public function getSemifinalistCountries():Array<Country>{
		return semifinalsCountries;
	}
	
	public function getFinalistCountries():Array<Country>{
		return finalCountries;
	}
	
	public function getPlayerCountry():Country{
		return playerCountry;
	}
	
	public function getTournamentState():Int{
		return tournamentState;
	}
	
	public function setTournamentState(state:Int):Void{
		this.tournamentState = state;
	}
	
	public function setChampion(aChampion:Country):Void{
		this.champion = aChampion;
	}
	
	public function getChampion():Country{
		return this.champion;
	}
	
	public function simulateMatchesRoundOfFour():Void{
		trace("SIMULANDO PARTIDO " + participatingCountries[2] + " .VS. " + participatingCountries[3]);
		this.semifinalsCountries.push(simulate(participatingCountries[2], participatingCountries[3]));
		trace("SIMULANDO PARTIDO " + participatingCountries[4] + " .VS. " + participatingCountries[5]);
		this.semifinalsCountries.push(simulate(participatingCountries[4], participatingCountries[5]));
		trace("SIMULANDO PARTIDO " + participatingCountries[6] + " .VS. " + participatingCountries[7]);
		this.semifinalsCountries.push(simulate(participatingCountries[6], participatingCountries[7]));
	}
	
	public function simulateMatchesSemifinals():Void{
		trace("SIMULANDO PARTIDO " + semifinalsCountries[2] + " .VS. " + semifinalsCountries[3]);
		this.finalCountries.push(simulate(semifinalsCountries[2], semifinalsCountries[3]));
	}
	
	public function simulate(country1:Country, country2: Country):Country{
		var probArray:Array<Country> = [];
		for (i in 0...country1.getDifficulty()){
			probArray.push(country1);
		}
		for (i in 0...country2.getDifficulty()){
			probArray.push(country2);
		}
		return Random.fromArray(probArray);
	}
	
	public function pushToSemifinalists(country:Country):Void{
		semifinalsCountries.insert(0, country);
	}
	
	public function pushToFinalists(country:Country):Void{
		finalCountries.insert(0, country);
	}
	
	

}