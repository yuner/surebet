library SportsLeague;

import '../../../base.dart';

const k_SportsLeagueID='SportsLeagueID';        //String:IDkey
const k_LeagueDisplayName='LeagueDisplayName';  //String
const k_LeagueAliasNames='LeagueAliasNames';    //List<String>
const k_NameFilterRegExp='NameFilterRegExp';    //String:RegExp

class SportsLeague
{
  IDkey SportsLeagueID;
  String LeagueDisplayName;
  List<String> LeagueAliasNames;
  RegExp NameFilterRegExp;

  Map<String,dynamic> toMap()
  {
    return {k_SportsLeagueID:SportsLeagueID
            ,k_LeagueDisplayName:LeagueDisplayName
            ,k_LeagueAliasNames:LeagueAliasNames
            ,k_NameFilterRegExp:NameFilterRegExp.pattern};
  }

  static SportsLeague fromMap(Map<String,dynamic> map)
  {
    return new SportsLeague()
                ..SportsLeagueID=map[k_SportsLeagueID]
                ..LeagueDisplayName=map[k_LeagueDisplayName]
                ..LeagueAliasNames=map[k_LeagueAliasNames]
                ..NameFilterRegExp=new RegExp(map[k_NameFilterRegExp]);
  }
}