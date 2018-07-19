package states;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import gameObjects.Button;
import gameObjects.Country;
import helpers.CountryManager;
import helpers.StoreManager;
import helpers.WalletManager;
import openfl.Assets;
import gameObjects.Team;
import helpers.TeamList;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import helpers.Tools;
using Lambda;


/**
 * ...
 * @author Alejandro Grunwaldt
 */
class StoreState extends FlxState
{
	private var background:FlxSprite;
	private var btnBuyTeam: Button;
	private var btnBack: Button;
	private var selectedTeamId: Int;
	private var walletStatus:FlxText;
	inline static var WALLET_ID:Float = 200;
	
	public function new() 
	{
		super();
	}
	
	override function create():Void
	{
		super.create();
		FlxG.scaleMode = new FixedScaleMode();
		
		background = Tools.getSpriteWithSize('img/practiceBack.png',FlxG.width,FlxG.height);
		background.x = 0;
		background.y = 0;

		add(background);

		btnBuyTeam = new Button(700, 64, 'img/Buttons/next.png', 'img/Buttons/nextHover.png', 'img/Buttons/nextClick.png');
		btnBuyTeam.btn.onUp.callback = onBuy;
		add(btnBuyTeam.btn);
		
		btnBack = new Button(82, 64, 'img/Buttons/back.png', 'img/Buttons/backHover.png', 'img/Buttons/backClick.png');
		btnBack.btn.onUp.callback = onBack;
		add(btnBack.btn);
		
		loadFlags();
		loadWalletDisplay();
	}
	
	private function loadWalletDisplay():Void
	{
		var funds = WalletManager.Instance().getFunds();
		setWalletLabel(funds);
	}
	private function setWalletLabel(funds: Int){
		var x = Math.ceil(FlxG.width / 2);
		var y = Math.ceil(FlxG.height * 0.05);
		walletStatus = Tools.getTextLabel(x, y, '$' + funds, 40);
		walletStatus.ID = WALLET_ID;
		var currentWalletLabel = this.members.filter(function (member) return member.ID == WALLET_ID ).pop();
		if (currentWalletLabel != null) {
			remove(currentWalletLabel);
		}
		add(walletStatus);
	}
	
	private function loadFlags():Void
	{
		for (i in 0...4) 
		{
			var x = Math.ceil((FlxG.width / 5) * (i)) + 90;
			var y = Math.ceil(FlxG.height / 4);
			var country = CountryManager.Instance()._countries[i];
			var name = country.getName();
			var label = Tools.getTextLabel(x + 10, y + 100, '$' + country.getCost(), 30);
			var btnC1Team ;
			if (country.isLocked()) 
			{
				btnC1Team = new Button(x, y, 'img/Flags/' + name + 'LockedFlag.png', 'img/Flags/' + name + 'LockedFlag.png', 'img/Flags/' + name + 'LockedFlag.png');
			} else {
				btnC1Team = new Button(x, y, 'img/Flags/' + name + 'Flag.png', 'img/Flags/' + name + 'Flag.png', 'img/Flags/' + name + 'Flag.png');
			}
			btnC1Team.btn.ID = i;
			btnC1Team.btn.onUp.callback = onSelectTeam.bind(i);
			add(btnC1Team.btn);
			add(label);
		}
		for (i in 4...8) 
		{
			var x = Math.ceil((FlxG.width / 5) * ((i % 4))) + 90;
			var y = Math.ceil(FlxG.height / 2);
			var country = CountryManager.Instance()._countries[i];
			var name = country.getName();
			var label = Tools.getTextLabel(x + 10, y + 100, '$' + country.getCost(), 30);
			var btnC1Team ;
			if (country.isLocked()) 
			{
				btnC1Team = new Button(x, y, 'img/Flags/' + name + 'LockedFlag.png', 'img/Flags/' + name + 'LockedFlag.png', 'img/Flags/' + name + 'LockedFlag.png');
			} else {
				btnC1Team = new Button(x, y, 'img/Flags/' + name + 'Flag.png', 'img/Flags/' + name + 'Flag.png', 'img/Flags/' + name + 'Flag.png');
			}
			btnC1Team.btn.ID = i;
			btnC1Team.btn.onUp.callback = onSelectTeam.bind(i);
			add(btnC1Team.btn);
			add(label);
		}
	}
	
	private function onBuy():Void
	{
		try 
		{
			var selectedCountry = CountryManager.Instance()._countries[this.selectedTeamId];
			if (selectedCountry.isLocked()) 
			{
				StoreManager.Instance().purchase(selectedCountry);
				var flags = this.members.filter(isFlagButton);
				flags.iter(function(flag) remove(flag));
				loadFlags();
				loadWalletDisplay();
			}
		}
	}
	private function isFlagButton(FlxBasic): Bool {
		return FlxBasic.ID >= 0 && FlxBasic.ID < 8 ;
	}
	
	private function onSelectTeam(id: Int):Void
	{
		this.selectedTeamId = id;
	}

	private function onBack():Void
	{
		FlxG.switchState(new SelectModeState());
	}	
}







	
