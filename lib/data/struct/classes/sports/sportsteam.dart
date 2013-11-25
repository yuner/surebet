library SportsTeam;

const SportsTeamID='SportsLeagueID';
const TeamDisplayName='TeamDisplayName';
const TeamAliasNames='TeamAliasNames';
const NameFilterRegExp='NameFilterRegExp';

class SportsTeam
{
  String SportsTeamID;
  String TeamDisplayName;
  List<String> TeamAliasNames;
  RegExp NameFilterRegExp;
}