
package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import gameObjects.Country;
import openfl.Assets;
import helpers.Tools;
import gameObjects.Button;
import gameObjects.Country;
import gameObjects.Tournament;
import helpers.PlayMode;
import helpers.TournamentStages;

/**
 * ...
 * @author Alejandro Grunwaldt
 */
class TournamentState  extends FlxState
{
	private var background:FlxSprite;
	private var tournament:Tournament;
	private var btnPlay:Button;
	private var btnFlag1: FlxSprite = null;
	private var btnFlag2: FlxSprite = null;
	private var btnFlag3: FlxSprite = null;
	private var btnFlag4: FlxSprite = null;
	private var btnFlag5: FlxSprite = null;
	private var btnFlag6: FlxSprite = null;
	private var btnFlag7: FlxSprite = null;
	private var btnFlag8: FlxSprite = null;
	
	private var btnFlag9: FlxSprite = null;
	private var btnFlag10: FlxSprite = null;
	private var btnFlag11: FlxSprite = null;
	private var btnFlag12: FlxSprite = null;
	
	private var btnFlag13: FlxSprite = null;
	private var btnFlag14: FlxSprite = null;
	
	private var btnCup: FlxSprite = null;
	private var btnChampionText: FlxSprite = null;
	private var btnChampion: FlxSprite = null;
	
	
	public function new(?country:Country, ?t:Tournament)
	{
		super();
		background = Tools.getSpriteWithSize('img/tournamentBack.png',FlxG.width,FlxG.height);
		background.x = 0;
		background.y = 0;
		add(background);
		
		btnPlay = new Button(760, 40, 'img/Buttons/play.png', 'img/Buttons/playHover.png', 'img/Buttons/playClick.png');
		btnPlay.btn.onUp.callback = play;
		add(btnPlay.btn);
		
		if (t == null){
			this.tournament = new Tournament(country);
			addFlagsRoundFour(this.tournament.getParticipatingCountries());
		}else{
			this.tournament = t;
			if (this.tournament.getTournamentState() == TournamentStages.SemiFinals){
				addFlagsRoundFour(this.tournament.getParticipatingCountries());
				addFlagsSemiFinals(this.tournament.getSemifinalistCountries());
			}else if (this.tournament.getTournamentState() == TournamentStages.Final){
				addFlagsRoundFour(this.tournament.getParticipatingCountries());
				addFlagsSemiFinals(this.tournament.getSemifinalistCountries());
				addFlagsFinal(this.tournament.getFinalistCountries());
			}else if (this.tournament.getTournamentState() == TournamentStages.EndedWin){
				addFlagsRoundFour(this.tournament.getParticipatingCountries());
				addFlagsSemiFinals(this.tournament.getSemifinalistCountries());
				addFlagsFinal(this.tournament.getFinalistCountries());
				makeChampion();
			}else if (this.tournament.getTournamentState() == TournamentStages.EndedLoose){
				addFlagsRoundFour(this.tournament.getParticipatingCountries());
				addFlagsSemiFinals(this.tournament.getSemifinalistCountries());
				addFlagsFinal(this.tournament.getFinalistCountries());
				makeChampion();
			}
		}
		
	}

	
	override function create():Void
	{
		super.create();
		
		var btnBack = new Button(40, 40, 'img/Buttons/back.png', 'img/Buttons/backHover.png', 'img/Buttons/backClick.png');
		btnBack.btn.onUp.callback = back;
		add(btnBack.btn);
	}
	
	private function addFlagsRoundFour(countries: Array<Country>):Void
	{
		var semifinalCountries:Array<Country> = null;
		var inSemisOrFinals:Bool = false;
		if (this.tournament.getTournamentState() >= TournamentStages.SemiFinals){
			inSemisOrFinals = true;
			semifinalCountries = tournament.getSemifinalistCountries();
		}
		
		var currentCountry = this.tournament.getPlayerCountry();
		var currentCountryName = currentCountry.getName();
		if (btnFlag1 != null){
			remove(btnFlag1);
			btnFlag1 = null;
		}
		btnFlag1 = Tools.getSpriteWithSize('img/Flags/' + currentCountryName + 'Flag.png', 75, 55);
		if (inSemisOrFinals){
			if (semifinalCountries[0].getName() != currentCountryName){
				btnFlag1 = Tools.getSpriteWithSize('img/Flags/' + currentCountryName + 'FlagClick.png', 75, 55);
			}
		}
		btnFlag1.x = 32;
		btnFlag1.y = 126;
		add(btnFlag1);
		
		var allCountries:Array<Country> = countries.copy();
		allCountries.remove(currentCountry);
		
		if (btnFlag2 != null){
			remove(btnFlag2);
			btnFlag2 = null;
		}
		btnFlag2 = Tools.getSpriteWithSize('img/Flags/' + allCountries[0].getName() + 'Flag.png', 75, 55);
		if (inSemisOrFinals){
			if (semifinalCountries[0].getName() != allCountries[0].getName()){
				btnFlag2 = Tools.getSpriteWithSize('img/Flags/' + allCountries[0].getName() + 'FlagClick.png', 75, 55);
			}
		}
		btnFlag2.x = 32;
		btnFlag2.y = 222;
		add(btnFlag2);
		
		if (btnFlag3 != null){
			remove(btnFlag3);
			btnFlag3 = null;
		}
		btnFlag3 = Tools.getSpriteWithSize('img/Flags/' + allCountries[1].getName() + 'Flag.png', 75, 55);
		if (inSemisOrFinals){
			if (semifinalCountries[1].getName() != allCountries[1].getName()){
				btnFlag3 = Tools.getSpriteWithSize('img/Flags/' + allCountries[1].getName() + 'FlagClick.png', 75, 55);
			}
		}
		btnFlag3.x = 32;
		btnFlag3.y = 334;
		add(btnFlag3);
		
		if (btnFlag4 != null){
			remove(btnFlag4);
			btnFlag4 = null;
		}
		btnFlag4 = Tools.getSpriteWithSize('img/Flags/' + allCountries[2].getName() + 'Flag.png', 75, 55);
		if (inSemisOrFinals){
			if (semifinalCountries[1].getName() != allCountries[2].getName()){
				btnFlag4 = Tools.getSpriteWithSize('img/Flags/' + allCountries[2].getName() + 'FlagClick.png', 75, 55);
			}
		}
		btnFlag4.x = 32;
		btnFlag4.y = 430;
		add(btnFlag4);
		
		if (btnFlag5 != null){
			remove(btnFlag5);
			btnFlag5 = null;
		}
		btnFlag5 = Tools.getSpriteWithSize('img/Flags/' + allCountries[3].getName() + 'Flag.png', 75, 55);
		if (inSemisOrFinals){
			if (semifinalCountries[2].getName() != allCountries[3].getName()){
				btnFlag5 = Tools.getSpriteWithSize('img/Flags/' + allCountries[3].getName() + 'FlagClick.png', 75, 55);
			}
		}
		btnFlag5.x = 790;
		btnFlag5.y = 126;
		add(btnFlag5);
		
		if (btnFlag6 != null){
			remove(btnFlag6);
			btnFlag6 = null;
		}
		btnFlag6 = Tools.getSpriteWithSize('img/Flags/' + allCountries[4].getName() + 'Flag.png', 75, 55);
		if (inSemisOrFinals){
			if (semifinalCountries[2].getName() != allCountries[4].getName()){
				btnFlag6 = Tools.getSpriteWithSize('img/Flags/' + allCountries[4].getName() + 'FlagClick.png', 75, 55);
			}
		}
		btnFlag6.x = 790;
		btnFlag6.y = 222;
		add(btnFlag6);
		
		if (btnFlag7 != null){
			remove(btnFlag7);
			btnFlag7 = null;
		}
		btnFlag7 = Tools.getSpriteWithSize('img/Flags/' + allCountries[5].getName() + 'Flag.png', 75, 55);
		if (inSemisOrFinals){
			if (semifinalCountries[3].getName() != allCountries[5].getName()){
				btnFlag7 = Tools.getSpriteWithSize('img/Flags/' + allCountries[5].getName() + 'FlagClick.png', 75, 55);
			}
		}
		btnFlag7.x = 790;
		btnFlag7.y = 334;
		add(btnFlag7);
		
		if (btnFlag8 != null){
			remove(btnFlag8);
			btnFlag8 = null;
		}
		btnFlag8 = Tools.getSpriteWithSize('img/Flags/' + allCountries[6].getName() + 'Flag.png', 75, 55);
		if (inSemisOrFinals){
			if (semifinalCountries[3].getName() != allCountries[6].getName()){
				btnFlag8 = Tools.getSpriteWithSize('img/Flags/' + allCountries[6].getName() + 'FlagClick.png', 75, 55);
			}
		}
		btnFlag8.x = 790;
		btnFlag8.y = 430;
		add(btnFlag8);
		
	}
	
	
	private function addFlagsSemiFinals(countries: Array<Country>):Void
	{
		var finalCountries:Array<Country> = null;
		var inFinals:Bool = false;
		if (this.tournament.getTournamentState() >= TournamentStages.Final){
			inFinals = true;
			finalCountries = tournament.getFinalistCountries();
		}
		
		var allCountries:Array<Country> = countries.copy();
		
		if (btnFlag9 != null){
			remove(btnFlag9);
			btnFlag9 = null;
		}
		btnFlag9 = Tools.getSpriteWithSize('img/Flags/' + allCountries[0].getName() + 'Flag.png', 75, 55);
		if (inFinals){
			if (finalCountries[0].getName() != allCountries[0].getName()){
				btnFlag9 = Tools.getSpriteWithSize('img/Flags/' + allCountries[0].getName() + 'FlagClick.png', 75, 55);
			}
		}
		btnFlag9.x = 178;
		btnFlag9.y = 172;
		add(btnFlag9);
		
		if (btnFlag10 != null){
			remove(btnFlag10);
			btnFlag10 = null;
		}
		btnFlag10 = Tools.getSpriteWithSize('img/Flags/' + allCountries[1].getName() + 'Flag.png', 75, 55);
		if (inFinals){
			if (finalCountries[0].getName() != allCountries[1].getName()){
				btnFlag10 = Tools.getSpriteWithSize('img/Flags/' + allCountries[1].getName() + 'FlagClick.png', 75, 55);
			}
		}
		btnFlag10.x = 178;
		btnFlag10.y = 380;
		add(btnFlag10);
		
		if (btnFlag11 != null){
			remove(btnFlag11);
			btnFlag11 = null;
		}
		btnFlag11 = Tools.getSpriteWithSize('img/Flags/' + allCountries[2].getName() + 'Flag.png', 75, 55);
		if (inFinals){
			if (finalCountries[1].getName() != allCountries[2].getName()){
				btnFlag11 = Tools.getSpriteWithSize('img/Flags/' + allCountries[2].getName() + 'FlagClick.png', 75, 55);
			}
		}
		btnFlag11.x = 643;
		btnFlag11.y = 172;
		add(btnFlag11);
		
		if (btnFlag12 != null){
			remove(btnFlag12);
			btnFlag12 = null;
		}
		btnFlag12 = Tools.getSpriteWithSize('img/Flags/' + allCountries[3].getName() + 'Flag.png', 75, 55);
		if (inFinals){
			if (finalCountries[1].getName() != allCountries[3].getName()){
				btnFlag12 = Tools.getSpriteWithSize('img/Flags/' + allCountries[3].getName() + 'FlagClick.png', 75, 55);
			}
		}
		btnFlag12.x = 643;
		btnFlag12.y = 380;
		add(btnFlag12);
	}
	
	private function addFlagsFinal(countries: Array<Country>):Void
	{
		var champion:Country = null;
		var finished:Bool = false;
		if (this.tournament.getTournamentState() >= TournamentStages.EndedWin){
			finished = true;
			champion = tournament.getChampion();
		}
		
		var allCountries:Array<Country> = countries.copy();
		
		if (btnFlag13 != null){
			remove(btnFlag13);
			btnFlag13 = null;
		}
		btnFlag13 = Tools.getSpriteWithSize('img/Flags/' + allCountries[0].getName() + 'Flag.png', 75, 55);
		if (finished){
			if (champion.getName() != allCountries[0].getName()){
				btnFlag13 = Tools.getSpriteWithSize('img/Flags/' + allCountries[0].getName() + 'FlagClick.png', 75, 55);
			}
		}
		btnFlag13.x = 327;
		btnFlag13.y = 275;
		add(btnFlag13);
		
		if (btnFlag14 != null){
			remove(btnFlag14);
			btnFlag14 = null;
		}
		btnFlag14 = Tools.getSpriteWithSize('img/Flags/' + allCountries[1].getName() + 'Flag.png', 75, 55);
		if (finished){
			if (champion.getName() != allCountries[1].getName()){
				btnFlag14 = Tools.getSpriteWithSize('img/Flags/' + allCountries[1].getName() + 'FlagClick.png', 75, 55);
			}
		}
		btnFlag14.x = 495;
		btnFlag14.y = 275;
		add(btnFlag14);
	}
	
	private function makeChampion():Void
	{
		if (btnCup != null){
			remove(btnCup);
			btnCup = null;
		}
		btnCup = Tools.getSpriteWithSize('img/WorldCup.png', 150, 176);
		btnCup.x = 377;
		btnCup.y = 55;
		add(btnCup);
		
		if (btnChampionText != null){
			remove(btnChampionText);
			btnChampionText = null;
		}
		btnChampionText = Tools.getSpriteWithSize('img/ChampionText.png', 186, 49);
		btnChampionText.x = 356;
		btnChampionText.y = 345;
		add(btnChampionText);
		
		if (btnChampion != null){
			remove(btnChampion);
			btnCup = null;
		}
		var champion = tournament.getChampion();
		btnChampion = Tools.getSpriteWithSize('img/Flags/' + champion.getName() + 'Flag.png', 150, 110);
		btnChampion.x = 368;
		btnChampion.y = 390;
		add(btnChampion);
		
		
		this.btnPlay.btn.active = false;
	}
	
	private function back():Void
	{
		trace("vuelta");
		FlxG.switchState(new SelectModeState());
	}
	
	private function play():Void
	{
		if (this.tournament.getTournamentState() == TournamentStages.RoundOfFour){
			var countries:Array<Country> = tournament.getParticipatingCountries();
			tournament.simulateMatchesRoundOfFour();
			FlxG.switchState(new MatchState(countries[0], countries[1],PlayMode.TOURNAMENT, this.tournament));
		}else if (this.tournament.getTournamentState() == TournamentStages.SemiFinals){
			var countries:Array<Country> = tournament.getSemifinalistCountries();
			tournament.simulateMatchesSemifinals();
			FlxG.switchState(new MatchState(countries[0], countries[1],PlayMode.TOURNAMENT, this.tournament));
		}else if (this.tournament.getTournamentState() == TournamentStages.Final){
			var countries:Array<Country> = tournament.getFinalistCountries();
			FlxG.switchState(new MatchState(countries[0], countries[1],PlayMode.TOURNAMENT, this.tournament));
		}
	}
	
	
	
		
}




	
	
