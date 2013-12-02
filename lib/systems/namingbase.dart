part of sysbase;

abstract class NameWrapperBase extends VMbase
{
  Map<String,SL.SportsLeague> _LeagueMap={};
  Map<String,ST.SportsTeam> _TeamMap={};

  Map<String,String> _LeagueCache={};
  Map<String,String> _TeamCache={};


  Map<String,Map<String,dynamic>> _replaceToID(Map<String,Map<String,dynamic>> eventCollection)
  {
    if (eventCollection==null) return eventCollection;

    eventCollection.keys.forEach((key){
      var evt=eventCollection[key];
      String league=evt[SE.LeagueName];
      String hostTeam=evt[SE.HostTeamName];
      String guestTeam=evt[SE.GuestTeamName];

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

  }


  void replaceToID(Map<String,dynamic> msg)
  {
    Map<String,Map<String,dynamic>> eventCollection=msg[M_ReplaceToID.eventList];

    var ec=_replaceToID(eventCollection);

    if (ec!=null) postMsg({MSG.k_msgid:N_MSG.replaceToID
                          ,M_IDReplaced.eventList:ec});
  }

  void updateNames(Map<String,dynamic> msg)
  {
    Map<String,Map<String,dynamic>> leagueCollection=msg[M_updateNames.leagueNames];
    Map<String,Map<String,dynamic>> teamCollection=msg[M_ReplaceToID.eventList];

    var upl=_updateLeagueNames(leagueCollection);
    var upt=_updateTeamNames(teamCollection);
    if (upl!=null) postMsg({MSG.k_msgid:N_MSG.leagueNamesUpdated,
                   M_leagueUpdated.leagueNames:upl});
    if (upt!=null) postMsg({MSG.k_msgid:N_MSG.teamNamesUpdated,
      M_teamUpdated.TeamNames:upt});
  }

  Map<String,Map<String,dynamic>> _updateLeagueNames(Map<String,Map<String,dynamic>> leagueCollection)
  {
    if (leagueCollection==null) return leagueCollection;
    var oldmap={};
    for (var key in leagueCollection)
    {
      var league=leagueCollection[key];
      var lt=_LeagueMap.remove(key);
      oldmap[key]=(lt==null)?lt:lt.toMap();
      if (league!=null)
      {
        _LeagueMap[key]..SportsLeagueID=league[SL.k_SportsLeagueID]
                       ..LeagueDisplayName=league[SL.k_LeagueDisplayName]
                       ..LeagueAliasNames=league[SL.k_LeagueAliasNames]
                       ..NameFilterRegExp=new RegExp(league[SL.k_NameFilterRegExp]);
      }
    }
    return oldmap;
  }

  Map<String,Map<String,dynamic>> _updateTeamNames(Map<String,Map<String,dynamic>> teamCollection)
  {
    if (teamCollection==null) return teamCollection;
    var oldmap={};
    for (var key in teamCollection)
    {
      var team=teamCollection[key];
      var tt=_TeamMap.remove(key);
      oldmap[key]=(tt==null)?tt:tt.toMap();
      if (team!=null)
      {
        _TeamMap[key]..SportsTeamID=team[ST.k_SportsTeamID]
                     ..TeamDisplayName=team[ST.k_TeamDisplayName]
                     ..TeamAliasNames=team[ST.k_TeamAliasNames]
                     ..NameFilterRegExp=new RegExp(team[ST.k_NameFilterRegExp]);
      }
    }
    return oldmap;
  }



}
