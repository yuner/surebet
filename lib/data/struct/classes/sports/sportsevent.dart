library SportsEvent;

import '../../../base.dart';

import '../../types/sports/sportstype.dart' as ST;
import '../../types/sports/markettype.dart' as MT;
import 'sportsmarket.dart' as SM;

   const k_SportsEventID='SportsEventID';
   const k_SportType='SportsType';
   const k_LeagueID='LeagueID';
   const k_HostTeamID='HostTeamID';
   const k_GuestTeamID='GuestTeamID';
   const k_LeagueName='LeagueName';
   const k_HostTeamName='HostTeamName';
   const k_GuestTeamName='GuestTeamName';
   const k_MarketCollection='MarketCollection';

   class SportsEvent
   {
     IDkey SportsEventID;
     ST.SportTypes SportType;
     IDkey LeagueID;
     IDkey HostTeamID;
     IDkey GuestTeamID;
     String LeagueName;
     String HostTeamName;
     String GuestTeamName;
     Map<MT.MarketTypes,List<SM.SportsMarket>> MarketCollection;

     Map<String,dynamic> toMap()
     {
       var mc=new Map<String,dynamic>();

       MarketCollection.forEach((K,V)
           {
              var lis=new List<Map<String,dynamic>>();
              V.forEach((E){
                lis.add(E.toMap());
              });
              mc[K.typeid]=lis;
           });

       return {
         k_SportsEventID:SportsEventID,
         k_SportType:SportType.typeid,
         k_LeagueID:LeagueID,
         k_HostTeamID:HostTeamID,
         k_GuestTeamID:GuestTeamID,
         k_LeagueName:LeagueName,
         k_HostTeamName:HostTeamName,
         k_GuestTeamName:GuestTeamName,
         k_MarketCollection:mc
       };
     }

     static SportsEvent fromMap(Map<String,dynamic> map)
     {
       var nmc=new Map<MT.MarketTypes,List<SM.SportsMarket>>();

       Map<String,List<Map<String,dynamic>>> mc=map[k_MarketCollection];
       mc.forEach((K,V)
           {
              var key=MT.MarketTypes.types(K);
              var value=new List<SM.SportsMarket>();
              V.forEach((E){
                value.add(SM.SportsMarket.fromMap(E));
              });
              nmc[K]=V;
           });


       return new SportsEvent()
        ..SportsEventID=map[k_SportsEventID]
        ..SportType=ST.SportTypes.types(map[k_SportType])
        ..LeagueID=map[k_LeagueID]
        ..HostTeamID=map[k_HostTeamID]
        ..GuestTeamID=map[k_GuestTeamID]
        ..LeagueName=map[k_LeagueName]
        ..HostTeamName=map[k_HostTeamName]
        ..GuestTeamName=map[k_GuestTeamName]
        ..MarketCollection=nmc;
     }

   }