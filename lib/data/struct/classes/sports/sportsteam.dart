library SportsTeam;

import '../../../base.dart';

const k_SportsTeamID='SportsLeagueID';
const k_TeamDisplayName='TeamDisplayName';
const k_TeamAliasNames='TeamAliasNames';
const k_NameFilterRegExp='NameFilterRegExp';

class SportsTeam
{
  IDkey SportsTeamID;
  String TeamDisplayName;
  List<String> TeamAliasNames;
  RegExp NameFilterRegExp;

  Map<String,dynamic> toMap()
  {
    return {k_SportsTeamID:SportsTeamID
            ,k_TeamDisplayName:TeamDisplayName
            ,k_TeamAliasNames:TeamAliasNames
            ,k_NameFilterRegExp:NameFilterRegExp.pattern};
  }

  static SportsTeam fromMap(Map<String,dynamic> map)
  {
    return new SportsTeam()
                ..SportsTeamID=map[k_SportsTeamID]
                ..TeamDisplayName=map[k_TeamDisplayName]
                ..TeamAliasNames=map[k_TeamAliasNames]
                ..NameFilterRegExp=new RegExp(map[k_NameFilterRegExp]);
  }

}