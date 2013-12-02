library SportsEvent;

import '../../../base.dart';

import '../../types/sports/sportstype.dart' as ST;
import '../../types/sports/markettype.dart' as MT;
import 'sportsmarket.dart' as SM;

   const SportsEventID='SportsEventID';
   const SportType='SportsType';
   const LeagueID='LeagueID';
   const HostTeamID='HostTeamID';
   const GuestTeamID='GuestTeamID';
   const LeagueName='LeagueName';
   const HostTeamName='HostTeamName';
   const GuestTeamName='GuestTeamName';
   const MarketCollection='MarketCollection';

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
   }