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
	
	public function getCountries():Array<Country>{
		return participatingCountries;
	}
	

}