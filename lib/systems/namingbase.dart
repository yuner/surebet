part of sysbase;

abstract class NameWrapperBase extends VMbase
{
  Map<String,SL.SportsLeague> _LeagueMap={};
  Map<String,ST.SportsTeam> _TeamMap={};

  Map<String,String> _LeagueCache={};
  Map<String,String> _TeamCache={};


  void replaceToID(Map<String,Map<String,dynamic>> msg)
  {
    Map<String,Map<String,dynamic>> eventCollection=msg[M_ReplaceToID.eventList];

    eventCollection.keys.forEach((key){
      var evt=eventCollection[key];
      String league=evt[SE.LeagueID];
      String hostTeam=evt[SE.HostTeamID];
      String guestTeam=evt[SE.GuestTeamID];

      var uleague=league.toUpperCase();
      var uhostTeam=hostTeam.toUpperCase();
      var uguestTeam=guestTeam.toUpperCase();

      var leagueID=_LeagueCache[uleague];
      if (leagueID==null)
      {
        for (var id in _LeagueMap.keys)
        {
          var lalias=_LeagueMap[id];
          var lregexp=lalias.NameFilterRegExp;
          if (lregexp==null)
            for (String alias in lalias.LeagueAliasNames)
            {
              if (alias.toUpperCase()==uleague)
              {
                leagueID=lalias.SportsLeagueID;
                _LeagueCache[uleague]=leagueID;
                break;
              }
            }
          else if (lregexp.hasMatch(league))
          {
            leagueID=lalias.SportsLeagueID;
            _LeagueCache[uleague]=leagueID;
          }
          if (leagueID!=null)
            break;
        }
        if (leagueID==null)
        {
          // post a message to indicate new league name
          leagueID='*new* '+league;
        }
      }

      var hostTeamID=_TeamCache[uhostTeam];
      var guestTeamID=_TeamCache[uguestTeam];
      if (hostTeamID==null || guestTeamID==null)
      {
        for (var id in _TeamMap.keys)
        {
          var lteam=_TeamMap[id];
          var lregexp=lteam.NameFilterRegExp;
          if (lregexp==null)
            for (String alias in lteam.TeamAliasNames)
            {
              var ualias=alias.toUpperCase();
              if (hostTeamID==null && ualias==uhostTeam)
              {
                hostTeamID=lteam.SportsTeamID;
                _TeamCache[uhostTeam]=hostTeamID;
              }
              if (guestTeamID==null && ualias==uguestTeam)
              {
                guestTeamID=lteam.SportsTeamID;
                _TeamCache[uguestTeam]=guestTeamID;
              }
              if (hostTeamID!=null && guestTeamID!=null)
                break;
            }
          else
          {
            if (lregexp.hasMatch(hostTeam))
            {
              hostTeamID=lteam.SportsTeamID;
              _TeamCache[uhostTeam]=hostTeamID;
            }
            if (lregexp.hasMatch(guestTeam))
            {
              guestTeamID=lteam.SportsTeamID;
              _TeamCache[uguestTeam]=guestTeamID;
            }
          }
          if (hostTeamID!=null && guestTeamID!=null)
            break;
        }
        if (hostTeamID==null)
        {
          // post a message to indicate new team name
          hostTeamID='*new* '+hostTeam;
        }
        if (guestTeamID==null)
        {
          // post a message to indicate new team name
          guestTeamID='*new* '+guestTeam;
        }
      }

      evt[SE.LeagueID]=leagueID;
      evt[SE.HostTeamID]=hostTeamID;
      evt[SE.GuestTeamID]=guestTeamID;

    });

    postMsg(msg);
  }
}
