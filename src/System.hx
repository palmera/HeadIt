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
        var brasil = CreateTeam("Brazil");
        var chile = CreateTeam("Chile");
		
		
        all_teams.add_team(uruguay);
        all_teams.add_team(argentina);
        all_teams.add_team(brasil);
        all_teams.add_team(chile);
		
		return all_teams;
    }

    
}
