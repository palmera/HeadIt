package helpers;
import gameObjects.Team;

class TeamList 
{
	public static var instance(default, null):TeamList = new TeamList();
	private static var teams:Array<Team>;
	private static var created:Bool;
	private static var i:Int;
	private function new() 
	{
		teams = [];
		i = 0;
	}
	public function get_team_list():TeamList {
		return instance;
	}
	
	public function add_team(team:Team):Int{
		return teams.push(team);
	}
	public function get_team_at_pos(position:Int):Team{
		if (position > teams.length || position < 0) throw "Invalid position";
		return teams[position];
	}
	public function get_next_team():Team {
		if (i + 1 >= teams.length) i = 0;
		else i++;
		log();
		return teams[i];
	}
	public function get_previous_team():Team {
		if (i - 1 < 0) i = teams.length - 1;
		else i--;
		log();
		return teams[i];
	}
	
	public function log():Void {
		trace('current index: ' + i);
		trace('current team: ' + teams[i].get_name());
		trace('total teams: ' + teams.length);
	}
	
}