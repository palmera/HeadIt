package;
import gameObjects.Team;
import helpers.TeamList;

class System
{
    public static function CreateTeam(name:String):Team{
        return new Team(name);
    }
    public static function GetTeams():TeamList {

		var all_teams = TeamList.instance;
        var uruguay = CreateTeam("Uruguay");
        var argentina = CreateTeam("Argentina");
        var brasil = CreateTeam("Brasil");
        var chile = CreateTeam("Chile");
		
		uruguay.set_shirt('img/players/MichaelJordan-hd.png');
		argentina.set_shirt('img/players/Maradona-hd.png');
		brasil.set_shirt('img/players/Pele-hd.png');
		chile.set_shirt('img/players/Napoleon-hd.png');
        all_teams.add_team(uruguay);
        all_teams.add_team(argentina);
        all_teams.add_team(brasil);
        all_teams.add_team(chile);
		
		return all_teams;
    }

    
}
