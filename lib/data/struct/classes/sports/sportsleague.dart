library SportsLeague;

import '../../../base.dart';

const k_SportsLeagueID='SportsLeagueID';
const k_LeagueDisplayName='LeagueDisplayName';
const k_LeagueAliasNames='LeagueAliasNames';
const k_NameFilterRegExp='NameFilterRegExp';

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
}