package;
import gameObjects.Team;
import helpers.TeamList;

class System
{
    public static function CreateTeam(name:String):Team{
        return new Team(name);
    }
	private static var teams_initialized = false;
	public inline static var GRAVITY:Float = 600;
	public inline static var SPEED_X:Float = 300;
	
	
    public static function InitializeTeams():TeamList {
		var all_teams = TeamList.instance;
		if (!teams_initialized) 
		{
			trace('InitializeTeams called');
			
			var uruguay = CreateTeam("Uruguay");
			var argentina = CreateTeam("Argentina");
			var brasil = CreateTeam("Brazil");
			var chile = CreateTeam("Chile");
				
			all_teams.add_team(uruguay);
			all_teams.add_team(argentina);
			all_teams.add_team(brasil);
			all_teams.add_team(chile);
			teams_initialized = true;
		}
		return all_teams;
    }

    
}
