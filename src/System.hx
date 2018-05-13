package;
import gameObjects.Team;

class System
{
    public static function CreateTeam(name:String):Team{
        return new Team(name);
    }
    public static function GetTeams():List<Team> {
        var all_teams:List<Team>;

		all_teams = new List<Team>();
        var uruguay = CreateTeam("Uruguay");
        var argentina = CreateTeam("Argentina");
        var brasil = CreateTeam("Brasil");
        var chile = CreateTeam("Chile");

        all_teams.add(uruguay);
        all_teams.add(argentina);
        all_teams.add(brasil);
        all_teams.add(chile);
		
		return all_teams;
    }

    
}
